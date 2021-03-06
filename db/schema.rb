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

ActiveRecord::Schema.define(version: 2018_09_11_103809) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "relations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "target_user_id"
    t.boolean "friend"
    t.boolean "subscribe"
    t.boolean "block"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["block"], name: "index_relations_on_block"
    t.index ["friend"], name: "index_relations_on_friend"
    t.index ["subscribe"], name: "index_relations_on_subscribe"
    t.index ["target_user_id"], name: "index_relations_on_target_user_id"
    t.index ["user_id"], name: "index_relations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "relations", "users", column: "target_user_id", on_delete: :cascade
  add_foreign_key "relations", "users", on_delete: :cascade
end
