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

ActiveRecord::Schema.define(version: 2018_09_08_171848) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "line_notification_targets", force: :cascade do |t|
    t.bigint "user_id"
    t.string "token"
    t.jsonb "auth_hash"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_line_notification_targets_on_user_id"
  end

  create_table "search_keywords", force: :cascade do |t|
    t.bigint "user_id"
    t.string "keyword"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_search_keywords_on_user_id"
  end

  create_table "tv_programs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "search_keyword_id"
    t.string "url", default: "", null: false
    t.string "keyword", default: "", null: false
    t.datetime "start_at", null: false
    t.string "title", default: "", null: false
    t.string "description", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["search_keyword_id"], name: "index_tv_programs_on_search_keyword_id"
    t.index ["user_id"], name: "index_tv_programs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "remember_created_at"
    t.string "uid"
    t.string "provider"
    t.string "name"
    t.string "image"
    t.string "token"
    t.string "secret"
    t.text "description", default: "", null: false
    t.jsonb "auth_hash"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "line_notification_targets", "users"
  add_foreign_key "search_keywords", "users"
  add_foreign_key "tv_programs", "search_keywords"
  add_foreign_key "tv_programs", "users"
end
