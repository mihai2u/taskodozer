class CreateDiscussions < ActiveRecord::Migration
  def self.up
    create_table :discussions do |t|
      t.integer :project_id
      t.string :title
      t.integer :archived, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :discussions
  end
end
