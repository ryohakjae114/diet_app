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

ActiveRecord::Schema.define(version: 2022_12_05_074021) do

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

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.decimal "kcal"
    t.decimal "protein"
    t.decimal "fat"
    t.decimal "carb"
    t.decimal "df"
    t.string "around_qty"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "unit"
    t.decimal "weight"
    t.index ["name"], name: "index_items_on_name", unique: true
  end

  create_table "recipe_items", force: :cascade do |t|
    t.bigint "recipe_id"
    t.bigint "item_id"
    t.decimal "kcal"
    t.decimal "weight"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_recipe_items_on_item_id"
    t.index ["recipe_id", "item_id"], name: "index_recipe_items_on_recipe_id_and_item_id", unique: true
    t.index ["recipe_id"], name: "index_recipe_items_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "img_url"
    t.string "name"
    t.decimal "protein", default: "0.0"
    t.decimal "fat", default: "0.0"
    t.decimal "carb", default: "0.0"
    t.decimal "df", default: "0.0"
    t.integer "cook_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "kcal"
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
    t.decimal "height", precision: 6, scale: 3
    t.decimal "weight", precision: 6, scale: 3
    t.integer "gender", limit: 2
    t.date "birthday"
    t.text "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

end
