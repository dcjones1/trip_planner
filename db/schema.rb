# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_02_15_144515) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "flights", force: :cascade do |t|
    t.string "origin"
    t.string "destination"
    t.datetime "departure_date"
    t.datetime "return_date"
    t.datetime "departure_time"
    t.datetime "arrival_time"
    t.string "duration"
    t.float "price"
    t.string "travel_class"
    t.boolean "nonstop"
    t.string "flight_number"
    t.string "carrier"
    t.string "leg"
    t.string "connection_origin"
    t.string "connection_destination"
    t.datetime "connection_departure_date"
    t.datetime "connection_departure_time"
    t.datetime "connection_arrival_time"
    t.string "connection_duration"
    t.bigint "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_flights_on_trip_id"
  end

  create_table "grounds", force: :cascade do |t|
    t.string "origin"
    t.string "destination"
    t.string "duration"
    t.string "mode"
    t.string "directions", array: true
    t.bigint "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_grounds_on_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "duration"
    t.float "price"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_foreign_key "flights", "trips"
  add_foreign_key "grounds", "trips"
  add_foreign_key "trips", "users"
end
