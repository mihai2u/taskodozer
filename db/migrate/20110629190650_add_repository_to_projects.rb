class AddRepositoryToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :repository, :string
  end

  def self.down
    remove_column :projects, :repository
  end
end
