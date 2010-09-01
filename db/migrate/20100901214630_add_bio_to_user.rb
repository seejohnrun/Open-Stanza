class AddBioToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :biography, :text, :limit => 5000, :null => true
  end

  def self.down
    remove_column :users, :biography
  end
end
