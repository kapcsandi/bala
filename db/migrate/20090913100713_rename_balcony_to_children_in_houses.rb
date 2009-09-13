class RenameBalconyToChildrenInHouses < ActiveRecord::Migration
  def self.up
    rename_column :houses, :balcony, :children 
  end

  def self.down
    rename_column :houses, :children, :balcony
  end
end
