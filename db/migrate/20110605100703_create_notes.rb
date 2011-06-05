class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.text :content
      t.string :updates
      t.integer :user_id
      t.integer :task_id
      t.string :attachment
      t.string :attachment_content_type
      t.string :attachment_file_size
      t.string :attachment_file_name
      t.timestamps
    end
  end

  def self.down
    drop_table :notes
  end
end
