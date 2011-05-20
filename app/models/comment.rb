class Comment < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user

  attr_accessible :content, :private

  default_scope :order => 'created_at ASC'

  scope :public, :conditions => { :private => 0 }
  
  def private?
  	private != 0
  end

  validates_presence_of :content
end
