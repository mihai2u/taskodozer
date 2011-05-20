class Topic < ActiveRecord::Base
  belongs_to :discussion
  belongs_to :user
  has_many :subscriptions
  has_many :subscribers, :through => :subscriptions, :source => :user, :uniq => true
  has_many :comments

  attr_accessible :discussion_id, :title, :content, :subscriber_ids

  default_scope :order => 'created_at DESC'

  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :discussion_id
  
end
