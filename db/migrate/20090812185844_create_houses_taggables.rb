class CreateHousesTaggables < ActiveRecord::Migration
  def self.up
    create_table :houses_taggables do |t|
      t.integer :house_id
      t.integer :taggable_id

      t.timestamps
    end
  end

  def self.down
    drop_table :houses_taggables
  end
end
