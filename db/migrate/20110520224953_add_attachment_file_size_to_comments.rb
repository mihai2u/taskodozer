class AddAttachmentFileSizeToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :attachment_content_type, :string
    add_column :comments, :attachment_file_size, :string
    add_column :comments, :attachment_file_name, :string
  end

  def self.down
    remove_column :comments, :attachment_content_type
    remove_column :comments, :attachment_file_size
    remove_column :comments, :attachment_file_name
  end
end
