class AddFieldsToHouses < ActiveRecord::Migration
  def self.up
    add_column :houses, :bedroom, :integer
    add_column :houses, :living_room, :integer
    add_column :houses, :living_dining_room, :integer
    add_column :houses, :kitchen, :integer
    add_column :houses, :dining_room, :integer
    add_column :houses, :kitchen_dining_room, :integer
    add_column :houses, :balcony, :integer
    add_column :houses, :terrace_id, :integer
    add_column :houses, :garden_yn, :integer
    add_column :houses, :living_room_sq, :integer
    add_column :houses, :living_dining_room_sq, :integer
    add_column :houses, :kitchen_sq, :integer
    add_column :houses, :dining_room_sq, :integer
    add_column :houses, :kitchen_dining_room_sq, :integer
    add_column :houses, :terrace_sq, :integer
    add_column :houses, :balcony_sq, :integer
    add_column :houses, :yard_sq, :integer
    add_column :houses, :double_bed, :integer
    add_column :houses, :single_bed, :integer
    add_column :houses, :extra_bed, :integer
    add_column :houses, :pull_out_bed, :integer
    add_column :houses, :bathrooms, :integer
    add_column :houses, :shower_yn, :integer
    add_column :houses, :bathtub_yn, :integer
    add_column :houses, :shower_bathtub_yn, :integer
    add_column :houses, :wc, :integer
    add_column :houses, :wc_separated_yn, :integer
    add_column :houses, :fridge_yn, :integer
    add_column :houses, :coffe_machine_yn, :integer
    add_column :houses, :micro_yn, :integer
    add_column :houses, :stove_id, :integer
    add_column :houses, :sat_yn, :integer
    add_column :houses, :internet_yn, :integer
    add_column :houses, :clima_id, :integer
    add_column :houses, :pool_yn, :integer
    add_column :houses, :pool_sq, :integer
    add_column :houses, :garden_seats_yn, :integer
    add_column :houses, :grill_yn, :integer
    add_column :houses, :sunbath_seat_yn, :integer
    add_column :houses, :playground_yn, :integer
    add_column :houses, :parking_id, :integer
    add_column :houses, :distance_aquapark, :integer
    add_column :houses, :distance_shop, :integer
    add_column :houses, :distance_station, :integer
    add_column :houses, :distance_medical, :integer
    add_column :houses, :distance_mainroad, :integer
    add_column :houses, :owner_place_id, :integer
    add_column :houses, :animal_charge, :integer
    add_column :houses, :price_pre_season, :integer
    add_column :houses, :price_mid_season, :integer
    add_column :houses, :price_main_season, :integer
  end

  def self.down
    remove_column :houses, :price_main_season
    remove_column :houses, :price_mid_season
    remove_column :houses, :price_pre_season
    remove_column :houses, :animal_charge
    remove_column :houses, :owner_place_id
    remove_column :houses, :distance_mainroad
    remove_column :houses, :distance_medical
    remove_column :houses, :distance_station
    remove_column :houses, :distance_shop
    remove_column :houses, :distance_aquapark
    remove_column :houses, :parking_id
    remove_column :houses, :playground_yn
    remove_column :houses, :sunbath_seat_yn
    remove_column :houses, :grill_yn
    remove_column :houses, :garden_seats_yn
    remove_column :houses, :pool_sq
    remove_column :houses, :pool_yn
    remove_column :houses, :clima_id
    remove_column :houses, :internet_yn
    remove_column :houses, :sat_yn
    remove_column :houses, :stove_id
    remove_column :houses, :micro_yn
    remove_column :houses, :coffe_machine_yn
    remove_column :houses, :fridge_yn
    remove_column :houses, :wc_separated_yn
    remove_column :houses, :wc
    remove_column :houses, :shower_bathtub_yn
    remove_column :houses, :bathtub_yn
    remove_column :houses, :shower_yn
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
    remove_column :houses, :living_dining_room_sq
    remove_column :houses, :living_room_sq
    remove_column :houses, :garden_yn
    remove_column :houses, :terrace_id
    remove_column :houses, :balcony
    remove_column :houses, :kitchen_dining_room
    remove_column :houses, :dining_room
    remove_column :houses, :kitchen
    remove_column :houses, :living_dining_room
    remove_column :houses, :living_room
    remove_column :houses, :bedroom
  end
end
