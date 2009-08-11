class AddFurnishingIdToHouse < ActiveRecord::Migration
  def self.up
    add_column :houses, :furnishing_id, :integer
  end

  def self.down
    remove_column :houses, :furnishing_id
  end
end
