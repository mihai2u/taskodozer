class AddPlannedAtToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :planned_at, :datetime
  end

  def self.down
    remove_column :tasks, :planned_at
  end
end
