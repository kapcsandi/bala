class CreateHouseTypes < ActiveRecord::Migration
  def self.up
    create_table :house_types do |t|
      t.timestamps
    end
    HouseType.create_translation_table! :name => :string
  end
  
  def self.down
    HouseType.drop_translation_table!
    drop_table :house_types
  end
end
