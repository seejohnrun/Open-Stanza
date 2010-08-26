class AddCachedSlugToStanza < ActiveRecord::Migration
  def self.up
    add_column :stanzas, :cached_slug, :string
  end

  def self.down
    remove_column :stanzas, :cached_slug
  end
end
