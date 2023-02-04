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

ActiveRecord::Schema.define(version: 2023_02_04_073413) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_admins_on_name", unique: true
  end

  create_table "diaries", force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "introduction"
    t.string "icon"
    t.boolean "public_diary"
    t.boolean "public_body"
    t.boolean "activated", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_diaries_on_user_id"
  end

  create_table "exercise_records", force: :cascade do |t|
    t.string "name"
    t.decimal "kcal", precision: 7, scale: 3
    t.uuid "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_exercise_records_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.uuid "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_favorites_on_post_id"
    t.index ["user_id", "post_id"], name: "index_favorites_on_user_id_and_post_id", unique: true
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.decimal "kcal", precision: 8, scale: 3, default: "0.0"
    t.decimal "protein", precision: 8, scale: 3, default: "0.0"
    t.decimal "fat", precision: 8, scale: 3, default: "0.0"
    t.decimal "carb", precision: 8, scale: 3, default: "0.0"
    t.decimal "df", precision: 8, scale: 3, default: "0.0"
    t.string "around_qty"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "unit"
    t.decimal "weight", precision: 8, scale: 3, default: "0.0"
    t.uuid "user_id"
    t.index ["name", "user_id"], name: "index_items_on_name_and_user_id", unique: true
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "meal_menus", force: :cascade do |t|
    t.bigint "meal_id", null: false
    t.bigint "recipe_id", null: false
    t.integer "count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["meal_id"], name: "index_meal_menus_on_meal_id"
    t.index ["recipe_id"], name: "index_meal_menus_on_recipe_id"
  end

  create_table "meals", force: :cascade do |t|
    t.uuid "user_id"
    t.date "date"
    t.integer "timing"
    t.string "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["date", "timing"], name: "index_meals_on_date_and_timing", unique: true
    t.index ["user_id"], name: "index_meals_on_user_id"
  end

  create_table "my_set_recipes", force: :cascade do |t|
    t.integer "count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "recipe_id", null: false
    t.bigint "my_set_id", null: false
    t.index ["my_set_id"], name: "index_my_set_recipes_on_my_set_id"
    t.index ["recipe_id"], name: "index_my_set_recipes_on_recipe_id"
  end

  create_table "my_sets", force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "user_id"], name: "index_my_sets_on_name_and_user_id", unique: true
    t.index ["user_id"], name: "index_my_sets_on_user_id"
  end

  create_table "post_comments", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.uuid "user_id", null: false
    t.string "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_post_comments_on_post_id"
    t.index ["user_id"], name: "index_post_comments_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.uuid "user_id", null: false
    t.text "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "date"
    t.index ["user_id", "date"], name: "index_posts_on_user_id_and_date", unique: true
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "recipe_items", force: :cascade do |t|
    t.bigint "recipe_id"
    t.bigint "item_id"
    t.decimal "kcal", precision: 8, scale: 3, default: "0.0"
    t.decimal "weight", precision: 8, scale: 3, default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_recipe_items_on_item_id"
    t.index ["recipe_id", "item_id"], name: "index_recipe_items_on_recipe_id_and_item_id", unique: true
    t.index ["recipe_id"], name: "index_recipe_items_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "img_url"
    t.string "name"
    t.decimal "protein", precision: 8, scale: 3, default: "0.0"
    t.decimal "fat", precision: 8, scale: 3, default: "0.0"
    t.decimal "carb", precision: 8, scale: 3, default: "0.0"
    t.decimal "df", precision: 8, scale: 3, default: "0.0"
    t.integer "cook_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "kcal", precision: 8, scale: 3, default: "0.0"
    t.uuid "user_id"
    t.index ["name", "user_id"], name: "index_recipes_on_name_and_user_id", unique: true
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.uuid "follower_id"
    t.uuid "followed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "nickname", limit: 30
    t.string "email", limit: 127
    t.decimal "height", precision: 8, scale: 3, default: "0.0"
    t.decimal "weight", precision: 8, scale: 3, default: "0.0"
    t.integer "gender", limit: 2
    t.date "birthday"
    t.text "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "activated", default: true
    t.decimal "target_weight", precision: 4, scale: 1, default: "0.0"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "weight_records", force: :cascade do |t|
    t.uuid "user_id"
    t.decimal "weight", precision: 6, scale: 2, default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_weight_records_on_user_id"
  end

  add_foreign_key "diaries", "users"
  add_foreign_key "exercise_records", "users"
  add_foreign_key "favorites", "posts"
  add_foreign_key "items", "users"
  add_foreign_key "meal_menus", "meals"
  add_foreign_key "meal_menus", "recipes"
  add_foreign_key "meals", "users"
  add_foreign_key "my_set_recipes", "my_sets"
  add_foreign_key "my_set_recipes", "recipes"
  add_foreign_key "my_sets", "users"
  add_foreign_key "post_comments", "posts"
  add_foreign_key "post_comments", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "recipes", "users"
  add_foreign_key "weight_records", "users"
end
