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

ActiveRecord::Schema[7.1].define(version: 2024_05_28_044716) do
  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_articles_on_teacher_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.integer "article_id", null: false
    t.integer "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_comments_on_article_id"
    t.index ["student_id"], name: "index_comments_on_student_id"
  end

  create_table "currents", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.integer "teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_students_on_teacher_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_active_sessions", force: :cascade do |t|
    t.string "session_id"
    t.integer "teacher_id"
    t.boolean "status"
    t.integer "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_user_active_sessions_on_student_id"
    t.index ["teacher_id"], name: "index_user_active_sessions_on_teacher_id"
  end

  add_foreign_key "articles", "teachers"
  add_foreign_key "comments", "articles"
  add_foreign_key "comments", "students"
  add_foreign_key "students", "teachers"
  add_foreign_key "user_active_sessions", "students"
  add_foreign_key "user_active_sessions", "teachers"
end
