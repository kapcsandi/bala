class CreateReservations < ActiveRecord::Migration
  def self.up
    create_table :reservations do |t|
      t.integer :house_id
      t.date :from
      t.date :to
      t.integer :persons
      t.integer :user_id
      t.integer :status
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :reservations
  end
end
