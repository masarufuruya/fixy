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

ActiveRecord::Schema.define(version: 20170321114746) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achivements", force: :cascade do |t|
    t.integer "habit_id"
    t.date    "date"
    t.boolean "completed", default: false
    t.text    "memo"
    t.index ["habit_id"], name: "index_achivements_on_habit_id", using: :btree
  end

  create_table "days", force: :cascade do |t|
    t.string "name"
  end

  create_table "habit_days", force: :cascade do |t|
    t.integer  "habit_id"
    t.integer  "day_id"
    t.boolean  "checked",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "habits", force: :cascade do |t|
    t.string  "name",       null: false
    t.integer "user_id"
    t.date    "start_date"
    t.date    "end_date"
    t.index ["user_id"], name: "index_habits_on_user_id", using: :btree
  end

  create_table "memos", force: :cascade do |t|
    t.string   "body"
    t.integer  "habit_id"
    t.integer  "achivement_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["achivement_id"], name: "index_memos_on_achivement_id", using: :btree
    t.index ["habit_id"], name: "index_memos_on_habit_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
