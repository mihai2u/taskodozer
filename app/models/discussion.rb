class Discussion < ActiveRecord::Base
  belongs_to :project
  has_many :topics

  attr_accessible :project_id, :title, :archived

  default_scope :order => 'title'
end
