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

ActiveRecord::Schema.define(version: 20170602145444) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "counters", force: :cascade do |t|
    t.string  "title"
    t.string  "code"
    t.string  "color"
    t.string  "unit",                default: ""
    t.string  "village_code"
    t.boolean "editable_by_settler", default: true
  end

  create_table "groups", force: :cascade do |t|
    t.string "key",   limit: 255
    t.string "title", limit: 255
  end

  create_table "groups_roles", id: false, force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "role_id",  null: false
  end

  create_table "groups_users", id: false, force: :cascade do |t|
    t.integer "user_id",  null: false
    t.integer "group_id", null: false
  end

  create_table "meterings", force: :cascade do |t|
    t.float   "value"
    t.integer "month"
    t.integer "year"
    t.integer "tariff_id"
    t.integer "user_id"
    t.integer "property_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string  "title"
    t.string  "ptype"
    t.integer "user_id"
    t.integer "village_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "title",      limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "role_id", null: false
  end

  create_table "tariffs", force: :cascade do |t|
    t.float   "rate"
    t.integer "month"
    t.integer "year"
    t.string  "counter_code"
    t.integer "counter_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "title"
    t.string   "village_code"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "villages", force: :cascade do |t|
    t.string "title"
    t.string "code"
  end

end
