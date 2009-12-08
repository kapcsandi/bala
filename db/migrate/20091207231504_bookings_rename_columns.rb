class BookingsRenameColumns < ActiveRecord::Migration
  def self.up
    rename_column :bookings, :from, :start_at
    rename_column :bookings, :to, :end_at
  end

  def self.down
    rename_column :bookings, :end_at, :to
    rename_column :bookings, :start_at, :from
  end
end
