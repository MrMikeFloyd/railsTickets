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

ActiveRecord::Schema.define(version: 20171212160028) do

  create_table "claim_statuses", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "value"
  end

  create_table "claim_types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "claims", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "insert_user"
    t.string "update_user"
    t.integer "claim_type_id"
    t.integer "status"
  end

  create_table "documents", force: :cascade do |t|
    t.string "file"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "claim_id"
  end

  create_table "investigations", force: :cascade do |t|
    t.text "query_result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "claim_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.string "file"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "claim_id"
  end

  create_table "solutions", force: :cascade do |t|
    t.string "load_id"
    t.text "pid_info"
    t.text "description"
    t.string "pallet_id"
    t.integer "number_of_pallets"
    t.string "box_id"
    t.string "serial_number_example"
    t.integer "damage_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "claim_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
