class AddStatusToBooking < ActiveRecord::Migration
  def self.up
    add_column :bookings, :status_id, :integer, :default => 0
  end

  def self.down
    remove_column :bookings, :status_id
  end
end
