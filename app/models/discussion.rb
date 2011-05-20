class Discussion < ActiveRecord::Base
  belongs_to :project
  has_many :topics

  attr_accessible :project_id, :title, :archived

  default_scope :order => 'title'

  validates_presence_of :title
  validates_presence_of :project_id

end
