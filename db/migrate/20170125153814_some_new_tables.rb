class SomeNewTables < ActiveRecord::Migration
  def change

    create_table "groups", force: :cascade do |t|
      t.string "key",   limit: 255
      t.string "title", limit: 255
    end

    create_table "groups_users", id: false, force: :cascade do |t|
      t.integer "user_id",  null: false
      t.integer "group_id", null: false
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

    create_table "groups_roles", id: false, force: :cascade do |t|
      t.integer "group_id", null: false
      t.integer "role_id",  null: false
    end

    Rake::Task['users:create_groups'].invoke
  end
end
