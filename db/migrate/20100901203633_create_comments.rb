class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :user_id, :null => false
      t.integer :stanza_id, :null => false
      t.text :body, :limit => 5000, :null => false
      t.boolean :under_moderation, :null => false, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
