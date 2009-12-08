class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :houses, :city_id
    add_index :houses, :house_type_id
    add_index :houses, :condition_id
    add_index :houses, :furnishing_id
    add_index :discounts, :house_id
    add_index :houses_taggables, :house_id
    add_index :houses_taggables, :taggable_id
    add_index :houses_tags, :house_id
    add_index :houses_tags, :tag_id
    add_index :tags, :taggable_id
    add_index :houses_bookings, :booking_id
    add_index :houses_bookings, :house_id
  end

  def self.down
  end
end
