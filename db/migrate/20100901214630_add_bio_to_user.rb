class AddBioToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :biography, :text, :null => true
  end

  def self.down
    remove_column :users, :biography
  end
end
