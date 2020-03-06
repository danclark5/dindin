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

ActiveRecord::Schema.define(version: 2020_03_06_125718) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "meal_suggestion_logs", force: :cascade do |t|
    t.bigint "meal_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meal_id"], name: "index_meal_suggestion_logs_on_meal_id"
    t.index ["user_id"], name: "index_meal_suggestion_logs_on_user_id"
  end

  create_table "meals", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_meals_on_user_id"
  end

  create_table "meals_tags", id: false, force: :cascade do |t|
    t.bigint "meal_id"
    t.bigint "tag_id"
    t.index ["meal_id"], name: "index_meals_tags_on_meal_id"
    t.index ["tag_id"], name: "index_meals_tags_on_tag_id"
  end

  create_table "meals_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "meal_id"
    t.index ["meal_id"], name: "index_meals_users_on_meal_id"
    t.index ["user_id"], name: "index_meals_users_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scheduled_meals", force: :cascade do |t|
    t.bigint "meal_id"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["meal_id"], name: "index_scheduled_meals_on_meal_id"
    t.index ["user_id"], name: "index_scheduled_meals_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "preferred_timezone"
    t.string "user_type", default: "free", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "meal_suggestion_logs", "meals"
  add_foreign_key "meal_suggestion_logs", "users"
  add_foreign_key "meals", "users"
  add_foreign_key "scheduled_meals", "meals"
  add_foreign_key "scheduled_meals", "users"
end
