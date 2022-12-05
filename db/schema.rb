# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_11_23_182002) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cars", force: :cascade do |t|
    t.integer "fuel_type", null: false
    t.integer "fuel_consumption", null: false
    t.float "total_km", null: false
    t.float "carbon_footprint", default: 0.0, null: false
    t.bigint "footprint_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["footprint_id"], name: "index_cars_on_footprint_id"
  end

  create_table "flight_distances", force: :cascade do |t|
    t.string "from", default: "", null: false
    t.string "to", default: "", null: false
    t.string "km", default: "", null: false
    t.float "carbon_footprint", default: 0.0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "flights", force: :cascade do |t|
    t.string "from", null: false
    t.string "to", null: false
    t.float "carbon_footprint", default: 0.0, null: false
    t.bigint "footprint_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["footprint_id"], name: "index_flights_on_footprint_id"
  end

  create_table "foods", force: :cascade do |t|
    t.bigint "footprint_id"
    t.float "min_carbon_footprint", default: 0.0, null: false
    t.float "max_carbon_footprint", default: 0.0, null: false
    t.integer "beef", default: 0, null: false
    t.integer "lamb", default: 0, null: false
    t.integer "poultry", default: 0, null: false
    t.integer "pork", default: 0, null: false
    t.integer "fish", default: 0, null: false
    t.integer "milk_based", default: 0, null: false
    t.integer "cheese", default: 0, null: false
    t.integer "eggs", default: 0, null: false
    t.integer "coffee", default: 0, null: false
    t.integer "vegetables", default: 0, null: false
    t.integer "bread", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["footprint_id"], name: "index_foods_on_footprint_id"
  end

  create_table "footprints", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_footprints_on_user_id"
  end

  create_table "houses", force: :cascade do |t|
    t.float "electricity", null: false
    t.float "natural_gas", null: false
    t.float "wood", null: false
    t.float "carbon_footprint", default: 0.0, null: false
    t.bigint "footprint_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["footprint_id"], name: "index_houses_on_footprint_id"
  end

  create_table "public_transports", force: :cascade do |t|
    t.integer "transport_type", null: false
    t.float "total_km", null: false
    t.float "carbon_footprint", default: 0.0, null: false
    t.bigint "footprint_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["footprint_id"], name: "index_public_transports_on_footprint_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cars", "footprints"
  add_foreign_key "flights", "footprints"
  add_foreign_key "foods", "footprints"
  add_foreign_key "footprints", "users"
  add_foreign_key "houses", "footprints"
  add_foreign_key "public_transports", "footprints"
end
