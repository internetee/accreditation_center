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

ActiveRecord::Schema.define(version: 2018_11_15_182752) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_admins_on_unlock_token", unique: true
  end

  create_table "answered_questions", force: :cascade do |t|
    t.bigint "test_id"
    t.bigint "question_id"
    t.bigint "answer_id"
    t.index ["answer_id"], name: "index_answered_questions_on_answer_id"
    t.index ["question_id"], name: "index_answered_questions_on_question_id"
    t.index ["test_id", "question_id", "answer_id"], name: "one_answer_per_test_question", unique: true
    t.index ["test_id"], name: "index_answered_questions_on_test_id"
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.string "text_en", null: false
    t.boolean "correct", default: false, null: false
    t.string "text_et", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "text_en", null: false
    t.text "comment"
    t.string "text_et", null: false
  end

  create_table "tests", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "start", null: false
    t.datetime "end", null: false
    t.boolean "passed", default: false, null: false
  end

  add_foreign_key "answered_questions", "answers"
  add_foreign_key "answered_questions", "questions"
  add_foreign_key "answered_questions", "tests"
  add_foreign_key "answers", "questions"
end
