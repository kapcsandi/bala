class CreateLays < ActiveRecord::Migration
  def self.up
    create_table :lays do |t|
      t.timestamps
    end
    Lay.create_translation_table! :name => :string
  end
  
  def self.down
    Lay.drop_translation_table!
    drop_table :lays
  end
end
