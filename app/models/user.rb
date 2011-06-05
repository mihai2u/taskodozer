class User < ActiveRecord::Base
  belongs_to :company
  has_many :accesses
  has_many :projects, :through => :accesses, :uniq => true
  has_many :topics
  has_many :subscriptions
  has_many :subscribed_topics, :through => :subscriptions, :source => :topic
  has_many :comments
  has_many :notes
  has_many :tasks
  has_many :assigned_tasks, :class_name => "Task"

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me, :role, :company_id

  scope :clients, :conditions => { :role => "client" }
  scope :developers, :conditions => { :role => "developer" }
  scope :managers, :conditions => { :role => "admin" }

  before_create :setup_user

  ROLES = %w[admin developer client]

  def admin?
    role == "admin"
  end

  def developer?
  	role == "developer"
  end

  def client?
  	role == "client"
  end

  validates_presence_of :username

  private

  def setup_user
    if self.role.blank? # blank role comes from website registrations
      self.role = "client"
      if self.company_id.blank?
        new_company = Company.new(:name => self.username)
        new_company.save
        # TODO: check if the company is saved, due to possible validation errors - invalid slug
        self.company = new_company
      end
    end
  end

end
