# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_04_06_180721) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dice", force: :cascade do |t|
    t.string "name"
    t.bigint "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_dice_on_game_id"
  end

  create_table "faces", force: :cascade do |t|
    t.bigint "die_id", null: false
    t.string "name"
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["die_id"], name: "index_faces_on_die_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.bigint "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_games_on_created_by_id"
  end

  create_table "roll_logs", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_roll_logs_on_room_id"
    t.index ["user_id"], name: "index_roll_logs_on_user_id"
  end

  create_table "roll_results", force: :cascade do |t|
    t.bigint "roll_log_id", null: false
    t.bigint "face_id", null: false
    t.boolean "archived", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["face_id"], name: "index_roll_results_on_face_id"
    t.index ["roll_log_id"], name: "index_roll_results_on_roll_log_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.string "name"
    t.bigint "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "join_code", default: -> { "gen_random_uuid()" }, null: false
    t.index ["created_by_id"], name: "index_rooms_on_created_by_id"
    t.index ["game_id"], name: "index_rooms_on_game_id"
    t.index ["join_code"], name: "index_rooms_on_join_code", unique: true
  end

  create_table "user_rooms", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_user_rooms_on_room_id"
    t.index ["user_id", "room_id"], name: "index_user_rooms_on_user_id_and_room_id", unique: true
    t.index ["user_id"], name: "index_user_rooms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "dice", "games"
  add_foreign_key "faces", "dice"
  add_foreign_key "games", "users", column: "created_by_id"
  add_foreign_key "roll_logs", "rooms"
  add_foreign_key "roll_logs", "users"
  add_foreign_key "roll_results", "faces"
  add_foreign_key "roll_results", "roll_logs"
  add_foreign_key "rooms", "games"
  add_foreign_key "rooms", "users", column: "created_by_id"
  add_foreign_key "user_rooms", "rooms"
  add_foreign_key "user_rooms", "users"
end
