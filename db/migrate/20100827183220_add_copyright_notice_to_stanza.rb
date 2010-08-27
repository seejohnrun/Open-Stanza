class AddCopyrightNoticeToStanza < ActiveRecord::Migration
  def self.up
    add_column :stanzas, :copyright_notice, :string, :limit => 200
  end

  def self.down
    remove_column :stanzas, :copyright_notice
  end
end
