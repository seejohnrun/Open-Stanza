class MakePublicTheDefault < ActiveRecord::Migration
  def self.up
    change_column :stanzas, :public, :boolean, :default => true, :null => false
  end

  def self.down
    change_column :stanzas, :public, :boolean, :default => false, :null => false
  end
end
