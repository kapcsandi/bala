class CreateHouses < ActiveRecord::Migration
  def self.up
    create_table :houses do |t|
      t.integer :city_id
      t.string :code
      t.integer :house_type_id
      t.integer :condition_id
      t.integer :furnishing_id
      t.integer :persons
      t.integer :floor_area
      t.integer :animals
      t.integer :distance_center
      t.integer :distance_beach
      t.integer :distance_restaurant
      t.string :admin_description
      t.string :hidden_description
      t.timestamps
    end
    House.create_translation_table! :house_description => :string
  end
  
  def self.down
    House.drop_translation_table!
    drop_table :houses
  end
end
