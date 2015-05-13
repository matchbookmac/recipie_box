# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150513163530) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "categories_recipies", id: false, force: :cascade do |t|
    t.integer "category_id"
    t.integer "recipie_id"
  end

  add_index "categories_recipies", ["category_id"], name: "index_categories_recipies_on_category_id", using: :btree
  add_index "categories_recipies", ["recipie_id"], name: "index_categories_recipies_on_recipie_id", using: :btree

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
  end

  create_table "ingredients_recipies", id: false, force: :cascade do |t|
    t.integer "ingredient_id"
    t.integer "recipie_id"
  end

  add_index "ingredients_recipies", ["ingredient_id"], name: "index_ingredients_recipies_on_ingredient_id", using: :btree
  add_index "ingredients_recipies", ["recipie_id"], name: "index_ingredients_recipies_on_recipie_id", using: :btree

  create_table "recipies", force: :cascade do |t|
    t.string  "name"
    t.text    "instructions"
    t.integer "rating"
  end

end
