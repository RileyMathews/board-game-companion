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

ActiveRecord::Schema[7.0].define(version: 2023_04_21_161957) do
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

  create_table "resource_groups", force: :cascade do |t|
    t.string "name"
    t.bigint "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_resource_groups_on_game_id"
  end

  create_table "resources", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.string "name", null: false
    t.integer "min", default: 0, null: false
    t.integer "max", default: 1000, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "resource_group_id"
    t.index ["game_id", "name"], name: "index_resources_on_game_id_and_name", unique: true
    t.index ["game_id"], name: "index_resources_on_game_id"
    t.index ["resource_group_id"], name: "index_resources_on_resource_group_id"
  end

  create_table "roll_results", force: :cascade do |t|
    t.bigint "face_id", null: false
    t.bigint "roll_id", null: false
    t.boolean "archived", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["face_id"], name: "index_roll_results_on_face_id"
    t.index ["roll_id"], name: "index_roll_results_on_roll_id"
  end

  create_table "rolls", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "room_id"
    t.index ["room_id"], name: "index_rolls_on_room_id"
    t.index ["user_id"], name: "index_rolls_on_user_id"
  end

  create_table "room_resources", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.bigint "resource_id", null: false
    t.bigint "user_id"
    t.integer "ammount", default: 0, null: false
    t.index ["resource_id"], name: "index_room_resources_on_resource_id"
    t.index ["room_id", "resource_id", "user_id"], name: "index_room_resources_on_room_id_and_resource_id_and_user_id", unique: true
    t.index ["room_id"], name: "index_room_resources_on_room_id"
    t.index ["user_id"], name: "index_room_resources_on_user_id"
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
  add_foreign_key "resource_groups", "games"
  add_foreign_key "resources", "games"
  add_foreign_key "resources", "resource_groups"
  add_foreign_key "roll_results", "faces"
  add_foreign_key "roll_results", "rolls"
  add_foreign_key "rolls", "rooms"
  add_foreign_key "rolls", "users"
  add_foreign_key "room_resources", "resources"
  add_foreign_key "room_resources", "rooms"
  add_foreign_key "room_resources", "users"
  add_foreign_key "rooms", "games"
  add_foreign_key "rooms", "users", column: "created_by_id"
  add_foreign_key "user_rooms", "rooms"
  add_foreign_key "user_rooms", "users"
end
