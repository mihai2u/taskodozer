class Comment < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user

  attr_accessible :content, :secret, :attachment, :remove_attachment

  mount_uploader :attachment, AttachmentUploader

  default_scope :order => 'created_at ASC'

  scope :public, :conditions => { :secret => 0 }
  
  def secret?
  	secret != 0
  end

  validates_presence_of :content

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
