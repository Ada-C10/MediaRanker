

ActiveRecord::Schema.define(version: 2018_10_14_202708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "work_id"
    t.integer "user_id"
  end

  create_table "works", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "creator"
    t.string "publication_year"
    t.string "description"
    t.string "category"
    t.integer "votes_count", default: 0
  end

end
