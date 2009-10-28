class CreateBookings < ActiveRecord::Migration
  def self.up
    create_table :bookings do |t|
      t.date :from
      t.date :to
      t.integer :nights
      t.integer :persons
      t.boolean :with_animals
      t.text :notes
      t.string :phone
      t.string :mobile
      t.string :email
      t.string :firstname
      t.string :lastname
      t.string :company
      t.string :address
      t.string :city
      t.string :postcode
      t.string :country
      t.timestamps
    end
  end
  
  def self.down
    drop_table :bookings
  end
end
