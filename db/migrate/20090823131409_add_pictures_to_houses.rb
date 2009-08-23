class AddPicturesToHouses < ActiveRecord::Migration
  def self.up
    add_column :houses, :pictures, :string
  end

  def self.down
    remove_column :houses, :pictures
  end
end
