class FixFieldSizesAndSuch < ActiveRecord::Migration
  def self.up
    change_column :users, :display_name, :string, :limit => 50, :null => true
    change_column :stanzas, :title, :string, :limit => 100, :null => false
    add_index :users, [:short_name], :unique => true, :name => 'short_name_unique'
  end

  def self.down
    remove_index :users, :short_name_unique
    change_column :stanzas, :title, :string, :limit => 255, :null => false
    change_column :users, :display_name, :string, :limit => 255, :null => false
  end
end
