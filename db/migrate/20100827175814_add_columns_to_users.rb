class AddColumnsToUsers < ActiveRecord::Migration
  def self.up
    rename_column :users, :name, :display_name
    add_column :users, :short_name, :string, :null => true, :limit => 50
  end

  def self.down
    rename_column :users, :display_name, :name
    remove_column :users, :short_name
  end
end
