class AddNotesToHousesBookings < ActiveRecord::Migration
  def self.up
    add_column :houses_bookings, :notes, :text
  end

  def self.down
    remove_column :houses_bookings, :notes
  end
end
