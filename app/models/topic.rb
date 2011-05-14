class Topic < ActiveRecord::Base

  belongs_to :discussion
  belongs_to :user

  attr_accessible :discussion_id, :title, :content
  
end
