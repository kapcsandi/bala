class AddFieldsToBookings < ActiveRecord::Migration
  def self.up
    add_column :bookings, :children, :integer
    add_column :bookings, :price, :integer
    add_column :bookings, :children_years, :string, :limit => 20
    add_column :bookings, :animal_details, :string, :limit => 50
    add_column :bookings, :salut, :string, :limit => 20
    add_column :bookings, :fax, :string, :limit => 20
  end

  def self.down
    remove_column :bookings, :salut
    remove_column :bookings, :animal_details
    remove_column :bookings, :children_years
    remove_column :bookings, :price
    remove_column :bookings, :children
  end
end
