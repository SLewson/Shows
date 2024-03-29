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

ActiveRecord::Schema.define(version: 20141211205910) do

  create_table "episodes", force: true do |t|
    t.integer  "show_id"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hulu_video_id"
    t.float    "rating"
    t.string   "type"
  end

  add_index "episodes", ["show_id"], name: "index_episodes_on_show_id"

  create_table "episodes_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "episode_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "episodes_users", ["episode_id"], name: "index_episodes_users_on_episode_id"
  add_index "episodes_users", ["user_id"], name: "index_episodes_users_on_user_id"

  create_table "shows", force: true do |t|
    t.string   "name"
    t.string   "network"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hulu_id"
    t.string   "description"
    t.string   "genre"
  end

  create_table "shows_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "show_id"
  end

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
