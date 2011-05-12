class AddArchivedToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :archived, :integer, :default => 0
  end

  def self.down
    remove_column :projects, :archived
  end
end
