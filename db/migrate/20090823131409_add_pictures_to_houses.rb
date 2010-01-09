class AddPicturesToHouses < ActiveRecord::Migration
  def self.up
    add_column :houses, :pictures, :text
  end

  def self.down
    remove_column :houses, :pictures
  end
end
