class CreateFurnishings < ActiveRecord::Migration
  def self.up
    create_table :furnishings do |t|
      t.integer :id
      t.timestamps
    end
    Furnishing.create_translation_table! :name => :string
  end
  
  def self.down
    Furniching.drop_translation_table!
    drop_table :furnishings
  end
end
