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

ActiveRecord::Schema.define(:version => 20090811183539) do

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "condition_translations", :force => true do |t|
    t.integer  "condition_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conditions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "furnishing_translations", :force => true do |t|
    t.integer  "furnishing_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "furnishings", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "house_translations", :force => true do |t|
    t.integer  "house_id"
    t.string   "locale"
    t.string   "kitchen_description"
    t.string   "bathroom_description"
    t.string   "yard_description"
    t.string   "other_description"
    t.string   "house_description"
    t.string   "owner_speaks"
    t.string   "bedroom_description"
    t.string   "owner_place"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "house_type_translations", :force => true do |t|
    t.integer  "house_type_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "house_types", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "houses", :force => true do |t|
    t.integer  "city_id"
    t.string   "code"
    t.integer  "persons"
    t.integer  "floor_area"
    t.integer  "animals"
    t.integer  "distance_center"
    t.integer  "distance_beach"
    t.integer  "distance_restaurant"
    t.integer  "house_type_id"
    t.integer  "condition_id"
    t.string   "admin_description"
    t.string   "hidden_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "furnishing_id"
  end

  create_table "lay_translations", :force => true do |t|
    t.integer  "lay_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lays", :force => true do |t|
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

  create_table "room_type_translations", :force => true do |t|
    t.integer  "room_type_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "room_types", :force => true do |t|
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
