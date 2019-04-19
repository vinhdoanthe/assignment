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

ActiveRecord::Schema.define(version: 2019_04_19_051108) do

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

  create_table "enrollments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_instance_id"
    t.date "start_date"
    t.date "end_date"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_instance_id"], name: "index_enrollments_on_course_instance_id"
    t.index ["user_id"], name: "index_enrollments_on_user_id"
  end

  create_table "graded_rubrics", force: :cascade do |t|
    t.integer "rubric_id"
    t.integer "type"
    t.string "status"
    t.decimal "point"
    t.text "cr1_des"
    t.decimal "cr1_score"
    t.boolean "cr1_enable"
    t.text "cr2_des"
    t.decimal "cr2_score"
    t.boolean "cr2_enable"
    t.text "cr3_des"
    t.decimal "cr3_score"
    t.boolean "cr3_enable"
    t.text "cr4_des"
    t.decimal "cr4_score"
    t.boolean "cr4_enable"
    t.text "cr5_des"
    t.decimal "cr5_score"
    t.boolean "cr5_enable"
    t.text "cr6_des"
    t.decimal "cr6_score"
    t.boolean "cr6_enable"
    t.text "cr7_des"
    t.decimal "cr7_score"
    t.boolean "cr7_enable"
    t.text "cr8_des"
    t.decimal "cr8_score"
    t.boolean "cr8_enable"
    t.text "cr9_des"
    t.decimal "cr9_score"
    t.boolean "cr9_enable"
    t.text "cr10_des"
    t.decimal "cr10_score"
    t.boolean "cr10_enable"
    t.text "cr11_des"
    t.decimal "cr11_score"
    t.boolean "cr11_enable"
    t.text "cr12_des"
    t.decimal "cr12_score"
    t.boolean "cr12_enable"
    t.text "cr13_des"
    t.decimal "cr13_score"
    t.boolean "cr13_enable"
    t.text "cr14_des"
    t.decimal "cr14_score"
    t.boolean "cr14_enable"
    t.text "cr15_des"
    t.decimal "cr15_score"
    t.boolean "cr15_enable"
    t.text "cr16_des"
    t.decimal "cr16_score"
    t.boolean "cr16_enable"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rubric_id"], name: "index_graded_rubrics_on_rubric_id"
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
    t.text "cr1_des"
    t.decimal "cr1_score"
    t.boolean "cr1_enable"
    t.text "cr2_des"
    t.decimal "cr2_score"
    t.boolean "cr2_enable"
    t.text "cr3_des"
    t.decimal "cr3_score"
    t.boolean "cr3_enable"
    t.text "cr4_des"
    t.decimal "cr4_score"
    t.boolean "cr4_enable"
    t.text "cr5_des"
    t.decimal "cr5_score"
    t.boolean "cr5_enable"
    t.text "cr6_des"
    t.decimal "cr6_score"
    t.boolean "cr6_enable"
    t.text "cr7_des"
    t.decimal "cr7_score"
    t.boolean "cr7_enable"
    t.text "cr8_des"
    t.decimal "cr8_score"
    t.boolean "cr8_enable"
    t.text "cr9_des"
    t.decimal "cr9_score"
    t.boolean "cr9_enable"
    t.text "cr10_des"
    t.decimal "cr10_score"
    t.boolean "cr10_enable"
    t.text "cr11_des"
    t.decimal "cr11_score"
    t.boolean "cr11_enable"
    t.text "cr12_des"
    t.decimal "cr12_score"
    t.boolean "cr12_enable"
    t.text "cr13_des"
    t.decimal "cr13_score"
    t.boolean "cr13_enable"
    t.text "cr14_des"
    t.decimal "cr14_score"
    t.boolean "cr14_enable"
    t.text "cr15_des"
    t.decimal "cr15_score"
    t.boolean "cr15_enable"
    t.text "cr16_des"
    t.decimal "cr16_score"
    t.boolean "cr16_enable"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id"], name: "index_rubrics_on_assignment_id"
  end

  create_table "submission_grades", force: :cascade do |t|
    t.integer "assignment_id"
    t.integer "student_id"
    t.string "submission_status"
    t.integer "attempt_count"
    t.boolean "latest"
    t.integer "mentor_id"
    t.string "grade_status"
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
    t.string "type"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
