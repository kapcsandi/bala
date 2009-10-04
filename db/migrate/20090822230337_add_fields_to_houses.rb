class AddFieldsToHouses < ActiveRecord::Migration
  def self.up
    add_column :houses, :bedroom, :integer
    add_column :houses, :living_room, :integer
    add_column :houses, :living_dining_room, :integer
    add_column :houses, :living_dining_kitchen, :integer
    add_column :houses, :kitchen, :integer
    add_column :houses, :dining_room, :integer
    add_column :houses, :kitchen_dining_room, :integer
    add_column :houses, :balcony, :integer
    add_column :houses, :terrace_id, :integer
    add_column :houses, :garden, :integer
    add_column :houses, :living_room_sq, :string
    add_column :houses, :living_dining_room_sq, :string
    add_column :houses, :kitchen_sq, :string
    add_column :houses, :kitchen_dining_room_sq, :string
    add_column :houses, :dining_room_sq, :string
    add_column :houses, :living_dining_kitchen_sq, :string
    add_column :houses, :terrace_sq, :string
    add_column :houses, :balcony_sq, :string
    add_column :houses, :yard_sq, :string
    add_column :houses, :double_bed, :integer
    add_column :houses, :single_bed, :string
    add_column :houses, :extra_bed, :integer
    add_column :houses, :pull_out_bed, :integer
    add_column :houses, :bathrooms, :integer
    add_column :houses, :shower, :integer
    add_column :houses, :bathtub, :integer
    add_column :houses, :wcs, :integer
    add_column :houses, :wc_separated, :integer
    add_column :houses, :fridge, :integer
    add_column :houses, :coffee_machine, :integer
    add_column :houses, :micro, :integer
    add_column :houses, :stove_id, :integer
    add_column :houses, :sat, :integer
    add_column :houses, :internet, :integer
    add_column :houses, :clima_id, :integer
    add_column :houses, :pool, :integer
    add_column :houses, :pool_sq, :integer
    add_column :houses, :garden_seats, :integer
    add_column :houses, :grill, :integer
    add_column :houses, :sunbath_seat, :integer
    add_column :houses, :playground, :integer
    add_column :houses, :parking_id, :integer
    add_column :houses, :distance_aquapark, :integer
    add_column :houses, :distance_shop, :integer
    add_column :houses, :distance_station, :integer
    add_column :houses, :distance_medical, :integer
    add_column :houses, :distance_mainroad, :integer
    add_column :houses, :owner_place_id, :integer
    add_column :houses, :animal_charge, :integer
    add_column :houses, :price_pre_season_per_day, :decimal, :precision => 5, :scale => 2
    add_column :houses, :price_mid_season_per_day, :decimal, :precision => 5, :scale =>  2
    add_column :houses, :price_main_season_per_day, :decimal, :precision => 5, :scale =>  2
    add_column :houses, :price_pre_season_per_week, :decimal, :precision => 5, :scale =>  2
    add_column :houses, :price_mid_season_per_week, :decimal, :precision => 5, :scale =>  2
    add_column :houses, :price_main_season_per_week, :decimal, :precision => 5, :scale =>  2
  end

  def self.down
    remove_column :houses, :price_main_season_per_week
    remove_column :houses, :price_mid_season_per_week
    remove_column :houses, :price_pre_season_per_week
    remove_column :houses, :price_main_season_per_day
    remove_column :houses, :price_mid_season_per_day
    remove_column :houses, :price_pre_season_per_day
    remove_column :houses, :animal_charge
    remove_column :houses, :owner_place_id
    remove_column :houses, :distance_mainroad
    remove_column :houses, :distance_medical
    remove_column :houses, :distance_station
    remove_column :houses, :distance_shop
    remove_column :houses, :distance_aquapark
    remove_column :houses, :parking_id
    remove_column :houses, :playground
    remove_column :houses, :sunbath_seat
    remove_column :houses, :grill
    remove_column :houses, :garden_seats
    remove_column :houses, :pool_sq
    remove_column :houses, :pool
    remove_column :houses, :clima_id
    remove_column :houses, :internet
    remove_column :houses, :sat
    remove_column :houses, :stove_id
    remove_column :houses, :micro
    remove_column :houses, :coffee_machine
    remove_column :houses, :fridge
    remove_column :houses, :wc_separated
    remove_column :houses, :wcs
    remove_column :houses, :shower_bathtub
    remove_column :houses, :bathtub
    remove_column :houses, :shower
    remove_column :houses, :bathrooms
    remove_column :houses, :pull_out_bed
    remove_column :houses, :extra_bed
    remove_column :houses, :single_bed
    remove_column :houses, :double_bed
    remove_column :houses, :yard_sq
    remove_column :houses, :balcony_sq
    remove_column :houses, :terrace_sq
    remove_column :houses, :kitchen_dining_room_sq
    remove_column :houses, :dining_room_sq
    remove_column :houses, :kitchen_sq
    remove_column :houses, :living_dining_kitchen_sq
    remove_column :houses, :living_dining_room_sq
    remove_column :houses, :living_room_sq
    remove_column :houses, :garden
    remove_column :houses, :terrace_id
    remove_column :houses, :balcony
    remove_column :houses, :kitchen_dining_room
    remove_column :houses, :dining_room
    remove_column :houses, :kitchen
    remove_column :houses, :living_dining_kitchen
    remove_column :houses, :living_dining_room
    remove_column :houses, :living_room
    remove_column :houses, :bedroom
  end
end
