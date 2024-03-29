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

ActiveRecord::Schema.define(version: 2021_10_19_063852) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answer_questions", force: :cascade do |t|
    t.bigint "quiz_id"
    t.bigint "question_id"
    t.bigint "answer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_answer_id"
    t.index ["answer_id"], name: "index_answer_questions_on_answer_id"
    t.index ["question_id"], name: "index_answer_questions_on_question_id"
    t.index ["quiz_id"], name: "index_answer_questions_on_quiz_id"
    t.index ["user_answer_id"], name: "index_answer_questions_on_user_answer_id"
  end

  create_table "answers", force: :cascade do |t|
    t.string "title_en"
    t.string "title_ee"
    t.boolean "correct"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "question_id"
    t.bigint "user_answer_id"
    t.bigint "category_id"
    t.index ["category_id"], name: "index_answers_on_category_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_answer_id"], name: "index_answers_on_user_answer_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "quiz_id"
    t.index ["quiz_id"], name: "index_categories_on_quiz_id"
  end

  create_table "practice_results", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "result"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_practice_results_on_user_id"
  end

  create_table "practices", force: :cascade do |t|
    t.bigint "user_id"
    t.boolean "result"
    t.string "action_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_practices_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "category_id"
    t.integer "question_type"
    t.text "title_en"
    t.index ["category_id"], name: "index_questions_on_category_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "json_category_state"
    t.bigint "user_id"
    t.bigint "result_id"
    t.boolean "theory"
    t.index ["json_category_state"], name: "index_quizzes_on_json_category_state", using: :gin
    t.index ["result_id"], name: "index_quizzes_on_result_id"
    t.index ["user_id"], name: "index_quizzes_on_user_id"
  end

  create_table "results", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "user_answer_id"
    t.boolean "result"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "quiz_id", null: false
    t.decimal "percent"
    t.index ["quiz_id"], name: "index_results_on_quiz_id"
    t.index ["user_answer_id"], name: "index_results_on_user_answer_id"
    t.index ["user_id"], name: "index_results_on_user_id"
  end

  create_table "template_setting_displays", force: :cascade do |t|
    t.bigint "category_id"
    t.boolean "display"
    t.integer "count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_template_setting_displays_on_category_id"
  end

  create_table "user_answers", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_user_answers_on_user_id"
  end

  create_table "user_questions", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "question_id"
    t.bigint "quiz_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_user_questions_on_category_id"
    t.index ["question_id"], name: "index_user_questions_on_question_id"
    t.index ["quiz_id"], name: "index_user_questions_on_quiz_id"
    t.index ["user_id"], name: "index_user_questions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "superadmin_role", default: false
    t.boolean "user_role", default: true
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "answer_questions", "answers"
  add_foreign_key "answer_questions", "questions"
  add_foreign_key "answer_questions", "quizzes", on_delete: :cascade
  add_foreign_key "answers", "categories"
  add_foreign_key "practice_results", "users"
  add_foreign_key "practices", "users"
  add_foreign_key "quizzes", "results", on_delete: :cascade
  add_foreign_key "results", "quizzes", on_delete: :cascade
  add_foreign_key "results", "user_answers"
  add_foreign_key "results", "users"
  add_foreign_key "template_setting_displays", "categories"
  add_foreign_key "user_questions", "categories"
  add_foreign_key "user_questions", "questions"
  add_foreign_key "user_questions", "quizzes", on_delete: :cascade
  add_foreign_key "user_questions", "users"
end
