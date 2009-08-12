class CreateHousesTags < ActiveRecord::Migration
  def self.up
    create_table :houses_tags do |t|
      t.integer :house_id
      t.integer :tag_id

      t.timestamps
    end
  end

  def self.down
    drop_table :houses_tags
  end
end
