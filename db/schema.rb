# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_19_105421) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ingredient_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "icon_identifier"
    t.string "accent_color"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "ingredient_category_id"
    t.integer "user_id"
    t.index ["ingredient_category_id"], name: "index_ingredients_on_ingredient_category_id"
    t.index ["user_id"], name: "index_ingredients_on_user_id"
  end

  create_table "ingredients_meals", id: false, force: :cascade do |t|
    t.bigint "meal_id", null: false
    t.bigint "ingredient_id", null: false
    t.index ["ingredient_id"], name: "index_ingredients_meals_on_ingredient_id"
    t.index ["meal_id"], name: "index_ingredients_meals_on_meal_id"
  end

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
    t.string "recipe_url"
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
    t.boolean "is_live"
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

  create_table "shopping_list_items", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "ingredient_id"
    t.bigint "scheduled_meal_id"
    t.boolean "acquired"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "snooze_until"
    t.index ["ingredient_id"], name: "index_shopping_list_items_on_ingredient_id"
    t.index ["scheduled_meal_id"], name: "index_shopping_list_items_on_scheduled_meal_id"
    t.index ["user_id"], name: "index_shopping_list_items_on_user_id"
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

  add_foreign_key "ingredients", "ingredient_categories"
  add_foreign_key "meal_suggestion_logs", "meals"
  add_foreign_key "meal_suggestion_logs", "users"
  add_foreign_key "meals", "users"
  add_foreign_key "scheduled_meals", "meals"
  add_foreign_key "scheduled_meals", "users"
  add_foreign_key "shopping_list_items", "ingredients"
  add_foreign_key "shopping_list_items", "scheduled_meals"
  add_foreign_key "shopping_list_items", "users"
end
