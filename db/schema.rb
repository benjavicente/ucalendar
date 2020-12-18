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

ActiveRecord::Schema.define(version: 2020_12_16_004221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academic_units", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "campus", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "term_id"
    t.bigint "subject_id"
    t.bigint "academic_unit_id"
    t.bigint "campus_id"
    t.string "nrc", null: false
    t.integer "section", null: false
    t.integer "format"
    t.integer "total_vacancy"
    t.boolean "withdrawal?", default: true
    t.boolean "english?", default: false
    t.boolean "require_special_approval?", default: false
    t.index ["academic_unit_id"], name: "index_courses_on_academic_unit_id"
    t.index ["campus_id"], name: "index_courses_on_campus_id"
    t.index ["subject_id"], name: "index_courses_on_subject_id"
    t.index ["term_id"], name: "index_courses_on_term_id"
  end

  create_table "courses_teachers", id: false, force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "teacher_id"
    t.index ["course_id"], name: "index_courses_teachers_on_course_id"
    t.index ["teacher_id"], name: "index_courses_teachers_on_teacher_id"
  end

  create_table "exams", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "schedule_id"
    t.datetime "start", null: false
    t.datetime "end", null: false
    t.string "name", null: false
    t.index ["schedule_id"], name: "index_exams_on_schedule_id"
  end

  create_table "holidays", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "day", null: false
    t.string "name", null: false
    t.boolean "every_yeat", default: false, null: false
  end

  create_table "schedule_events", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "schedule_id"
    t.integer "category"
    t.string "classroom"
    t.integer "day", null: false
    t.integer "module", null: false
    t.index ["schedule_id"], name: "index_schedule_events_on_schedule_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.bigint "course_id"
    t.index ["course_id"], name: "index_schedules_on_course_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "code", null: false
    t.string "name", null: false
    t.integer "credits"
    t.string "fr_area"
    t.string "category"
    t.index ["code"], name: "index_subjects_on_code", unique: true
  end

  create_table "teachers", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", null: false
  end

  create_table "terms", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "year", null: false
    t.bigint "period", null: false
    t.date "first_day", null: false
    t.date "last_day", null: false
    t.index ["period"], name: "index_terms_on_period"
    t.index ["year"], name: "index_terms_on_year"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
