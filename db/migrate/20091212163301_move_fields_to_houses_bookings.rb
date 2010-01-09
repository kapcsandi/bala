class MoveFieldsToHousesBookings < ActiveRecord::Migration
  def self.up
    add_column :houses_bookings, :owner_id, :integer
    add_column :houses_bookings, :start_at, :date
    add_column :houses_bookings, :end_at, :date
    add_column :houses_bookings, :status_id, :integer, :default => 0
    add_column :houses_bookings, :description, :text
    remove_column :bookings, :status_id
    remove_column :bookings, :start_at
    remove_column :bookings, :end_at
  end

  def self.down
    remove_column :houses_bookings, :owner_id
    add_column :bookings, :start_at, :date
    add_column :bookings, :end_at, :date
    add_column :bookings, :status_id, :integer, :default => 0
    remove_column :houses_bookings, :description
    remove_column :houses_bookings, :status_id
    remove_column :houses_bookings, :start_at
    remove_column :houses_bookings, :end_at
  end
end
