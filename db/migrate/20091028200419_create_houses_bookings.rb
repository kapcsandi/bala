class CreateHousesBookings < ActiveRecord::Migration
  def self.up
    create_table :houses_bookings do |t|
      t.integer :house_id
      t.integer :booking_id
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :houses_bookings
  end
end
