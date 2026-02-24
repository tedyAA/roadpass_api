ActiveRecord::Schema[7.1].define(version: 2026_02_24_135647) do

  enable_extension "plpgsql"

  create_table "trips", force: :cascade do |t|
    t.string "name"
    t.string "image_url"
    t.string "short_description"
    t.text "long_description"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
