class AddStatusToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :status, :string, :default => "inquiry"
  end

  def self.down
    remove_column :projects, :status
  end
end
