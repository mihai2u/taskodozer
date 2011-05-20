class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :user_id
      t.integer :topic_id
      t.integer :private, :default => 0
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
