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

ActiveRecord::Schema.define(version: 2019_05_06_071252) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "assignments", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.decimal "point"
    t.integer "course_instance_id"
    t.string "status"
    t.integer "max_attempt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_instance_id"], name: "index_assignments_on_course_instance_id"
  end

  create_table "course_instances", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.text "description"
    t.date "start_date"
    t.date "end_date"
    t.integer "program_id"
    t.integer "course_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_instances_on_course_id"
    t.index ["program_id"], name: "index_course_instances_on_program_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "criteria_formats", force: :cascade do |t|
    t.integer "rubric_id"
    t.text "description"
    t.decimal "point"
    t.boolean "required"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "index", default: 0, null: false
    t.index ["rubric_id"], name: "index_criteria_formats_on_rubric_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_instance_id"
    t.date "start_date"
    t.date "end_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_instance_id"], name: "index_enrollments_on_course_instance_id"
    t.index ["user_id", "course_instance_id"], name: "index_enrollments_on_user_id_and_course_instance_id", unique: true
    t.index ["user_id"], name: "index_enrollments_on_user_id"
  end

  create_table "graded_criteria", force: :cascade do |t|
    t.integer "graded_rubric_id"
    t.text "description"
    t.decimal "point"
    t.boolean "required"
    t.boolean "is_passed"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "index", default: 0, null: false
    t.index ["graded_rubric_id"], name: "index_graded_criteria_on_graded_rubric_id"
  end

  create_table "graded_rubrics", force: :cascade do |t|
    t.integer "rubric_id"
    t.integer "rubric_type"
    t.string "status"
    t.decimal "point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "comment"
    t.integer "submission_grade_id"
    t.text "description"
    t.index ["rubric_id"], name: "index_graded_rubrics_on_rubric_id"
    t.index ["submission_grade_id"], name: "index_graded_rubrics_on_submission_grade_id"
  end

  create_table "programs", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rubrics", force: :cascade do |t|
    t.integer "assignment_id"
    t.integer "rubric_type"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["assignment_id"], name: "index_rubrics_on_assignment_id"
  end

  create_table "submission_grades", force: :cascade do |t|
    t.integer "assignment_id"
    t.integer "student_id"
    t.string "submission_status"
    t.integer "attempt_count"
    t.boolean "latest"
    t.integer "mentor_id"
    t.integer "graded_rubric_id"
    t.decimal "point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id"], name: "index_submission_grades_on_assignment_id"
    t.index ["graded_rubric_id"], name: "index_submission_grades_on_graded_rubric_id"
    t.index ["mentor_id"], name: "index_submission_grades_on_mentor_id"
    t.index ["student_id"], name: "index_submission_grades_on_student_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.string "status"
    t.string "full_name"
    t.string "funid"
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username", "funid"], name: "index_users_on_username_and_funid"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", limit: 8, null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object", limit: 1073741823
    t.datetime "created_at"
    t.text "object_changes", limit: 1073741823
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end
