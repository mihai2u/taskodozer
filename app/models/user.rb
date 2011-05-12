class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me, :role

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
  validates_presence_of :role
end
