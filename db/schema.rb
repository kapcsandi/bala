# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090823131409) do

  create_table "discount_translations", :force => true do |t|
    t.integer  "discount_id"
    t.string   "locale"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discounts", :force => true do |t|
    t.integer  "house_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "house_translations", :force => true do |t|
    t.integer  "house_id"
    t.string   "locale"
    t.string   "house_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "houses", :force => true do |t|
    t.integer  "city_id"
    t.string   "code"
    t.integer  "house_type_id"
    t.integer  "condition_id"
    t.integer  "furnishing_id"
    t.integer  "persons"
    t.integer  "floor_area"
    t.integer  "animals"
    t.integer  "distance_center"
    t.integer  "distance_beach"
    t.integer  "distance_restaurant"
    t.string   "admin_description"
    t.string   "hidden_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bedroom"
    t.integer  "living_room"
    t.integer  "living_dining_room"
    t.integer  "kitchen"
    t.integer  "dining_room"
    t.integer  "kitchen_dining_room"
    t.integer  "balcony"
    t.integer  "terrace_id"
    t.integer  "garden"
    t.integer  "living_room_sq"
    t.integer  "living_dining_room_sq"
    t.integer  "kitchen_sq"
    t.integer  "dining_room_sq"
    t.integer  "kitchen_dining_room_sq"
    t.integer  "terrace_sq"
    t.integer  "balcony_sq"
    t.integer  "yard_sq"
    t.integer  "double_bed"
    t.integer  "single_bed"
    t.integer  "extra_bed"
    t.integer  "pull_out_bed"
    t.integer  "bathrooms"
    t.integer  "shower"
    t.integer  "bathtub"
    t.integer  "shower_bathtub"
    t.integer  "wcs"
    t.integer  "wc_separated"
    t.integer  "fridge"
    t.integer  "coffee_machine"
    t.integer  "micro"
    t.integer  "stove_id"
    t.integer  "sat"
    t.integer  "internet"
    t.integer  "clima_id"
    t.integer  "pool"
    t.integer  "pool_sq"
    t.integer  "garden_seats"
    t.integer  "grill"
    t.integer  "sunbath_seat"
    t.integer  "playground"
    t.integer  "parking_id"
    t.integer  "distance_aquapark"
    t.integer  "distance_shop"
    t.integer  "distance_station"
    t.integer  "distance_medical"
    t.integer  "distance_mainroad"
    t.integer  "owner_place_id"
    t.integer  "animal_charge"
    t.integer  "price_pre_season"
    t.integer  "price_mid_season"
    t.integer  "price_main_season"
    t.string   "pictures"
  end

  create_table "houses_taggables", :force => true do |t|
    t.integer  "house_id"
    t.integer  "taggable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "houses_tags", :force => true do |t|
    t.integer  "house_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_translations", :force => true do |t|
    t.integer  "page_id"
    t.string   "locale"
    t.text     "body"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tag_translations", :force => true do |t|
    t.integer  "tag_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggable_translations", :force => true do |t|
    t.integer  "taggable_id"
    t.string   "locale"
    t.string   "context"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggables", :force => true do |t|
    t.string   "field"
    t.integer  "multi"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.integer  "taggable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
