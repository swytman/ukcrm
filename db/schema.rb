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

ActiveRecord::Schema.define(version: 20161229151027) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "counters", force: :cascade do |t|
    t.string "title"
    t.string "code"
    t.string "color"
    t.string "unit",  default: ""
  end

  create_table "meterings", force: :cascade do |t|
    t.float   "value"
    t.integer "month"
    t.integer "year"
    t.integer "tariff_id"
  end

  create_table "tariffs", force: :cascade do |t|
    t.float   "rate"
    t.integer "month"
    t.integer "year"
    t.string  "counter_code"
  end

end
