class User < ActiveRecord::Base
  belongs_to :company

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me, :role, :company_id

  before_create :setup_client

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

  def setup_client
    self.role = "client" if self.role.blank?
    if self.company_id.blank?
      new_company = Company.new(:name => self.username)
      new_company.save
      # TODO: check if the company is saved, due to possible validation errors - invalid slug
      self.company = new_company
    end
  end
end
