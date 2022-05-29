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

ActiveRecord::Schema[7.0].define(version: 2022_05_29_153014) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "commodities", force: :cascade do |t|
    t.string "name"
    t.string "symbol"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cryptos", force: :cascade do |t|
    t.string "name"
    t.string "symbol"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jokes", force: :cascade do |t|
    t.string "joke"
    t.string "categories"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "measurements", force: :cascade do |t|
    t.bigint "sensor_id", null: false
    t.float "temperature", null: false
    t.float "humidity", null: false
    t.float "soil_moisture", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sensor_id"], name: "index_measurements_on_sensor_id"
  end

  create_table "sensors", force: :cascade do |t|
    t.string "mac_address", null: false
    t.string "student"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sky_colors", force: :cascade do |t|
    t.string "location"
    t.integer "r"
    t.integer "g"
    t.integer "b"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.string "name"
    t.string "symbol"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "waters", force: :cascade do |t|
    t.string "name"
    t.float "flow"
    t.float "level"
    t.float "temperature"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weathers", force: :cascade do |t|
    t.date "date"
    t.string "location"
    t.float "temp"
    t.float "temp_min"
    t.float "temp_max"
    t.datetime "sunrise"
    t.datetime "sunset"
    t.float "rain"
    t.float "snow"
    t.string "weather"
    t.string "weather_description"
    t.string "weather_icon"
    t.float "wind_speed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "humidity"
    t.float "moon_phase"
    t.float "sun_position"
    t.float "sun_height"
  end

end
