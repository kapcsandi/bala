class AddBalconyIdToHouses < ActiveRecord::Migration
  def self.up
    add_column :houses, :balcony_id, :integer
  end

  def self.down
    remove_column :houses, :balcony_id
  end
end
