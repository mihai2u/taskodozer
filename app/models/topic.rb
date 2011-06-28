class Topic < ActiveRecord::Base
  belongs_to :discussion
  belongs_to :user
  has_many :subscriptions
  has_many :subscribers, :through => :subscriptions, :source => :user, :uniq => true
  has_many :comments

  attr_accessible :discussion_id, :title, :content, :subscriber_ids, :attachment, :remove_attachment
  mount_uploader :attachment, AttachmentUploader

  default_scope :order => 'created_at DESC'

  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :discussion_id

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
