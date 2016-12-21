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

ActiveRecord::Schema.define(version: 20161221092140) do

  create_table "lists", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "tasks_count", default: 0
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "lists_users", primary_key: "false", force: :cascade do |t|
    t.integer "list_id"
    t.integer "user_id"
    t.index ["list_id", "user_id"], name: "index_lists_users_on_list_id_and_user_id", unique: true
  end

  create_table "pending_emails", force: :cascade do |t|
    t.integer "list_id"
    t.string  "email"
    t.index ["list_id"], name: "index_pending_emails_on_list_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "title"
    t.integer  "priority",   default: 1
    t.integer  "status",     default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "done",       default: false
    t.integer  "list_id"
    t.index ["list_id"], name: "index_tasks_on_list_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
