class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :assigned_user, :class_name => "User"
  belongs_to :project
  has_one :parent, :class_name => "Task"

  attr_accessible :description, :status, :duration, :priority, :user_id, :assigned_user_id, :parent_id, :project_id, :secret

  PRIORITIES = %w[low medium high]
  STATUSES = %w[pending open resolved closed rejected]
end
