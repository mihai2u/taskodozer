class Note < ActiveRecord::Base
  belongs_to :task
  belongs_to :user

  attr_accessible :content, :updates, :user_id, :task_id, :attachment, :remove_attachment
  serialize :updates
  mount_uploader :attachment, AttachmentUploader

  default_scope :order => 'created_at ASC'

  before_save :update_attachment_attributes
  
  private
  
  def update_attachment_attributes
    unless attachment.file.blank?
      self.attachment_content_type = attachment.file.content_type
      self.attachment_file_size = attachment.file.size
      self.attachment_file_name = attachment_url.match(/[\w\s\.\-_]*$/).to_s
    end
  end
end
