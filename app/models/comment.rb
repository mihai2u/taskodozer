class Comment < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user

  attr_accessible :content, :secret

  default_scope :order => 'created_at ASC'

  scope :public, :conditions => { :secret => 0 }
  
  def secret?
  	secret != 0
  end

  validates_presence_of :content
end
