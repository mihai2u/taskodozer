class AddAttachmentToTopic < ActiveRecord::Migration
  def self.up
    add_column :topics, :attachment, :string
    add_column :topics, :attachment_content_type, :string
    add_column :topics, :attachment_file_size, :string
    add_column :topics, :attachment_file_name, :string
  end

  def self.down
    remove_column :topics, :attachment
    remove_column :topics, :attachment_content_type
    remove_column :topics, :attachment_file_size
    remove_column :topics, :attachment_file_name
  end
end