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

ActiveRecord::Schema.define(version: 20170710191112) do

  create_table "black_cards", force: :cascade do |t|
    t.text     "text"
    t.integer  "blanks"
    t.integer  "user_id"
    t.integer  "round_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "game_id"
    t.index ["round_id"], name: "index_black_cards_on_round_id"
    t.index ["user_id"], name: "index_black_cards_on_user_id"
  end

  create_table "black_decks", id: false, force: :cascade do |t|
    t.integer "game_id",       null: false
    t.integer "black_card_id", null: false
    t.index ["game_id", "black_card_id"], name: "index_black_decks_on_game_id_and_black_card_id"
  end

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "game_id", null: false
    t.index ["user_id", "game_id"], name: "index_games_users_on_user_id_and_game_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "number"
    t.integer  "user_id"
    t.integer  "black_card_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "winner_id"
    t.integer  "winning_white_card_id"
    t.index ["black_card_id"], name: "index_rounds_on_black_card_id"
    t.index ["game_id"], name: "index_rounds_on_game_id"
    t.index ["user_id"], name: "index_rounds_on_user_id"
  end

  create_table "rounds_white_cards", id: false, force: :cascade do |t|
    t.integer "round_id",      null: false
    t.integer "white_card_id", null: false
    t.index ["round_id", "white_card_id"], name: "index_rounds_white_cards_on_round_id_and_white_card_id"
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
    t.string   "name"
    t.integer  "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "white_cards", force: :cascade do |t|
    t.text     "text"
    t.integer  "user_id"
    t.integer  "round_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "black_card_id"
    t.boolean  "sfw"
    t.integer  "game_id"
    t.index ["round_id"], name: "index_white_cards_on_round_id"
    t.index ["user_id"], name: "index_white_cards_on_user_id"
  end

  create_table "white_decks", id: false, force: :cascade do |t|
    t.integer "game_id",       null: false
    t.integer "white_card_id", null: false
    t.index ["game_id", "white_card_id"], name: "index_white_decks_on_game_id_and_white_card_id"
  end

end
