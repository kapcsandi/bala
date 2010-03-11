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

ActiveRecord::Schema.define(:version => 20100310220824) do

  create_table "bookings", :force => true do |t|
    t.integer  "nights"
    t.integer  "persons"
    t.boolean  "with_animals"
    t.text     "notes"
    t.string   "phone"
    t.string   "mobile"
    t.string   "email"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "company"
    t.string   "address"
    t.string   "city"
    t.string   "postcode"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fax",            :limit => 20
    t.integer  "children"
    t.integer  "price"
    t.string   "children_years", :limit => 20
    t.string   "animal_details", :limit => 50
    t.string   "salut",          :limit => 20
  end

  create_table "discount_translations", :force => true do |t|
    t.integer  "discount_id"
    t.string   "locale"
    t.string   "description", :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "discount_translations", ["discount_id"], :name => "index_discount_translations_on_discount_id"
  add_index "discount_translations", ["locale"], :name => "index_discount_translations_on_locale"

  create_table "discounts", :force => true do |t|
    t.integer  "house_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "discounts", ["house_id"], :name => "index_discounts_on_house_id"

  create_table "event_logs", :force => true do |t|
    t.integer  "user_id"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_logs", ["created_at"], :name => "index_event_logs_on_created_at"

  create_table "house_seasons", :force => true do |t|
    t.integer  "house_id"
    t.integer  "season_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "house_translations", :force => true do |t|
    t.integer  "house_id"
    t.string   "locale"
    t.text     "house_description", :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "house_translations", ["house_id", "locale"], :name => "index_house_translations_on_house_id_and_locale"
  add_index "house_translations", ["house_id"], :name => "index_house_translations_on_house_id"
  add_index "house_translations", ["locale"], :name => "index_house_translations_on_locale"

  create_table "houses", :force => true do |t|
    t.integer  "city_id"
    t.string   "code"
    t.integer  "house_type_id"
    t.integer  "condition_id"
    t.integer  "furnishing_id"
    t.integer  "persons",                                                   :default => 0
    t.integer  "floor_area",                                                :default => 0
    t.integer  "animals",                                                   :default => 0
    t.integer  "distance_center",                                           :default => 0
    t.integer  "distance_beach",                                            :default => 0
    t.integer  "distance_restaurant",                                       :default => 0
    t.text     "admin_description",                                         :default => ""
    t.string   "hidden_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bedroom",                                                   :default => 0
    t.integer  "living_room",                                               :default => 0
    t.integer  "living_dining_room",                                        :default => 0
    t.integer  "living_dining_kitchen",                                     :default => 0
    t.integer  "kitchen",                                                   :default => 0
    t.integer  "dining_room",                                               :default => 0
    t.integer  "kitchen_dining_room",                                       :default => 0
    t.integer  "children",                                                  :default => 0
    t.integer  "terrace_id"
    t.integer  "garden",                                                    :default => 0
    t.string   "living_room_sq"
    t.string   "living_dining_room_sq"
    t.string   "kitchen_sq"
    t.string   "kitchen_dining_room_sq"
    t.string   "dining_room_sq"
    t.string   "living_dining_kitchen_sq"
    t.string   "terrace_sq"
    t.string   "balcony_sq"
    t.string   "yard_sq"
    t.integer  "double_bed",                                                :default => 0
    t.string   "single_bed"
    t.integer  "extra_bed",                                                 :default => 0
    t.integer  "pull_out_bed",                                              :default => 0
    t.integer  "bathrooms",                                                 :default => 0
    t.integer  "shower",                                                    :default => 0
    t.integer  "bathtub",                                                   :default => 0
    t.integer  "wcs",                                                       :default => 0
    t.integer  "wc_separated",                                              :default => 0
    t.integer  "fridge",                                                    :default => 0
    t.integer  "coffee_machine",                                            :default => 0
    t.integer  "micro",                                                     :default => 0
    t.integer  "stove_id"
    t.integer  "sat",                                                       :default => 0
    t.integer  "internet",                                                  :default => 0
    t.integer  "clima_id"
    t.integer  "pool",                                                      :default => 0
    t.integer  "pool_sq",                                                   :default => 0
    t.integer  "garden_seats",                                              :default => 0
    t.integer  "grill",                                                     :default => 0
    t.integer  "sunbath_seat",                                              :default => 0
    t.integer  "playground",                                                :default => 0
    t.integer  "parking_id"
    t.integer  "distance_aquapark",                                         :default => 0
    t.integer  "distance_shop",                                             :default => 0
    t.integer  "distance_station",                                          :default => 0
    t.integer  "distance_medical",                                          :default => 0
    t.integer  "distance_mainroad",                                         :default => 0
    t.integer  "owner_place_id"
    t.integer  "animal_charge",                                             :default => 0
    t.decimal  "price_pre_season_per_day",   :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.decimal  "price_mid_season_per_day",   :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.decimal  "price_main_season_per_day",  :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.decimal  "price_pre_season_per_week",  :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.decimal  "price_mid_season_per_week",  :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.decimal  "price_main_season_per_week", :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.text     "pictures"
    t.integer  "balcony_id"
  end

  add_index "houses", ["animals"], :name => "index_houses_on_animals"
  add_index "houses", ["city_id"], :name => "index_houses_on_city_id"
  add_index "houses", ["condition_id"], :name => "index_houses_on_condition_id"
  add_index "houses", ["furnishing_id"], :name => "index_houses_on_furnishing_id"
  add_index "houses", ["house_type_id"], :name => "index_houses_on_house_type_id"

  create_table "houses_bookings", :force => true do |t|
    t.integer  "house_id"
    t.integer  "booking_id"
    t.decimal  "position",   :precision => 10, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.date     "start_at"
    t.date     "end_at"
    t.integer  "status_id",                                 :default => 0
    t.text     "notes"
  end

  add_index "houses_bookings", ["booking_id"], :name => "index_houses_bookings_on_booking_id"
  add_index "houses_bookings", ["end_at"], :name => "index_houses_bookings_on_end_at"
  add_index "houses_bookings", ["house_id"], :name => "index_houses_bookings_on_house_id"
  add_index "houses_bookings", ["start_at"], :name => "index_houses_bookings_on_start_at"

  create_table "houses_taggables", :force => true do |t|
    t.integer  "house_id"
    t.integer  "taggable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "houses_taggables", ["house_id"], :name => "index_houses_taggables_on_house_id"
  add_index "houses_taggables", ["taggable_id"], :name => "index_houses_taggables_on_taggable_id"

  create_table "houses_tags", :force => true do |t|
    t.integer  "house_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "houses_tags", ["house_id"], :name => "index_houses_tags_on_house_id"
  add_index "houses_tags", ["tag_id"], :name => "index_houses_tags_on_tag_id"

  create_table "page_translations", :force => true do |t|
    t.integer  "page_id"
    t.string   "locale"
    t.text     "body"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "page_translations", ["locale", "page_id"], :name => "index_page_translations_on_page_id_and_locale"
  add_index "page_translations", ["locale"], :name => "index_page_translations_on_locale"
  add_index "page_translations", ["page_id"], :name => "index_page_translations_on_page_id"

  create_table "pages", :force => true do |t|
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "path"
  end

  add_index "pages", ["path", "published"], :name => "index_pages_on_published_and_path"
  add_index "pages", ["path"], :name => "index_pages_on_path"
  add_index "pages", ["published"], :name => "index_pages_on_published"

  create_table "seasons", :force => true do |t|
    t.string   "name"
    t.date     "start"
    t.date     "end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "active",     :default => 0, :null => false
  end

  add_index "seasons", ["name", "start"], :name => "index_seasons_on_name_and_start"
  add_index "seasons", ["name"], :name => "index_seasons_on_name"
  add_index "seasons", ["start"], :name => "index_seasons_on_start"

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

  add_index "tag_translations", ["locale", "tag_id"], :name => "index_tag_translations_on_tag_id_and_locale"
  add_index "tag_translations", ["locale"], :name => "index_tag_translations_on_locale"
  add_index "tag_translations", ["tag_id"], :name => "index_tag_translations_on_tag_id"

  create_table "taggable_translations", :force => true do |t|
    t.integer  "taggable_id"
    t.string   "locale"
    t.string   "context"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggable_translations", ["locale", "taggable_id"], :name => "index_taggable_translations_on_taggable_id_and_locale"
  add_index "taggable_translations", ["locale"], :name => "index_taggable_translations_on_locale"
  add_index "taggable_translations", ["taggable_id"], :name => "index_taggable_translations_on_taggable_id"

  create_table "taggables", :force => true do |t|
    t.string   "field"
    t.integer  "multi"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggables", ["field"], :name => "index_taggables_on_field"
  add_index "taggables", ["position"], :name => "index_taggables_on_position"

  create_table "tags", :force => true do |t|
    t.integer  "taggable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["taggable_id"], :name => "index_tags_on_taggable_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
  end

end
