class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :assigned_user, :class_name => "User"
  belongs_to :project
  belongs_to :parent, :class_name => "Task"
  has_many :tasks, :foreign_key => "parent_id"
  has_many :notes

  accepts_nested_attributes_for :notes, :reject_if => :all_blank
  attr_accessible :name, :description, :status, :duration, :priority, :assigned_user_id, :parent_id, :project_id, :secret, :notes, :note, :notes_attributes, :attachment, :remove_attachment
  mount_uploader :attachment, AttachmentUploader

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
  STATUSES = %w[pending development completed rejected]

  before_create :setup_task
  before_save :update_attachment_attributes

  private

  def setup_task
  	self.priority = "medium" if self.priority.blank?
  	self.status = "pending" if self.status.blank?
  end

  def update_attachment_attributes
    unless attachment.file.blank?
      self.attachment_content_type = attachment.file.content_type
      self.attachment_file_size = attachment.file.size
      self.attachment_file_name = attachment_url.match(/[\w\s\.\-_]*$/).to_s
    end
  end
end
