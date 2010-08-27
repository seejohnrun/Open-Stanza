class AddPublicToStanza < ActiveRecord::Migration
  def self.up
    add_column :stanzas, :public, :boolean, :default => false, :null => false
    add_column :stanzas, :published_at, :datetime
  end

  def self.down
    remove_column :stanzas, :public
    remove_column :stanzas, :published_at
  end
end
