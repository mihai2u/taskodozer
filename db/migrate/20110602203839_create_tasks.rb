class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.text :description
      t.string :status, :default => "pending"
      t.decimal :duration, :precision => 8, :scale => 2, :default => 0
      t.string :priority, :default => "medium"
      t.integer :secret, :default => 0
      t.integer :user_id
      t.integer :assigned_user_id
      t.integer :parent_id
      t.integer :project_id
      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
