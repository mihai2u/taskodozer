class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :assigned_user, :class_name => "User"
  belongs_to :project
  belongs_to :parent, :class_name => "Task"
  has_many :tasks, :foreign_key => "parent_id"

  attr_accessible :name, :description, :status, :duration, :priority, :assigned_user_id, :parent_id, :project_id, :secret

  default_scope :order => 'created_at ASC'

  scope :public, :conditions => { :secret => 0 }

  def secret?
  	secret != 0
  end

  def assignee
    if self.assigned_user.blank?
      "Unassigned"
    else
      self.assigned_user.username
    end
  end

  def longname
    "#" + self.id.to_s + " " + self.name
  end

  validates_presence_of :name
  validates_presence_of :description

  PRIORITIES = %w[low medium high]
  STATUSES = %w[pending open resolved closed rejected]

  before_create :setup_task

  private

  def setup_task
  	self.priority = "medium" if self.priority.blank?
  	self.status = "pending" if self.status.blank?
  end
end
