class CreateStanzas < ActiveRecord::Migration
  def self.up
    create_table :stanzas do |t|
      t.integer :user_id, :null => false
      t.string :title, :null => false
      t.text :body
      t.timestamps
    end
  end

  def self.down
    drop_table :stanzas
  end
end
