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

ActiveRecord::Schema.define(version: 2018_10_14_234651) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_works", force: :cascade do |t|
    t.bigint "work_id"
    t.bigint "category_id"
    t.index ["category_id"], name: "index_categories_works_on_category_id"
    t.index ["work_id"], name: "index_categories_works_on_work_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "handle"
  end

  create_table "votes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status"
    t.bigint "user_id"
    t.bigint "work_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
    t.index ["work_id"], name: "index_votes_on_work_id"
  end

  create_table "votes_intermediaries", force: :cascade do |t|
    t.string "table"
  end

  create_table "works", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "creator"
    t.string "description"
    t.integer "year"
    t.bigint "user_id"
    t.string "category"
    t.index ["user_id"], name: "index_works_on_user_id"
  end

  add_foreign_key "votes", "users"
  add_foreign_key "votes", "works"
  add_foreign_key "works", "users"
end
