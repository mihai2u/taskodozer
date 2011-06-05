class AddAttachmentToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :attachment, :string
    add_column :tasks, :attachment_content_type, :string
    add_column :tasks, :attachment_file_size, :string
    add_column :tasks, :attachment_file_name, :string
  end

  def self.down
    remove_column :tasks, :attachment
    remove_column :tasks, :attachment_content_type
    remove_column :tasks, :attachment_file_size
    remove_column :tasks, :attachment_file_name
  end
end
