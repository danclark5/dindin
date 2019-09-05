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

ActiveRecord::Schema.define(version: 2019_08_13_103130) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "meal_types", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meals", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scheduled_meals", force: :cascade do |t|
    t.bigint "meal_id"
    t.date "date"
    t.bigint "meal_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "schedule_id"
    t.index ["meal_id"], name: "index_scheduled_meals_on_meal_id"
    t.index ["meal_type_id"], name: "index_scheduled_meals_on_meal_type_id"
    t.index ["schedule_id"], name: "index_scheduled_meals_on_schedule_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.boolean "include_breakfast"
    t.boolean "include_lunch"
    t.boolean "include_dinner"
    t.integer "default_participant_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "scheduled_meals", "meal_types"
  add_foreign_key "scheduled_meals", "meals"
  add_foreign_key "scheduled_meals", "schedules"
end
