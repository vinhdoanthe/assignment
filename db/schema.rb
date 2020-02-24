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

ActiveRecord::Schema.define(version: 2019_11_30_145122) do

  create_table "active_admin_comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "assignments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.bigint "course_instance_id"
    t.string "assignment_status"
    t.integer "max_attempt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "grade_type"
    t.string "submit_type"
    t.datetime "deleted_at"
    t.index ["course_instance_id"], name: "index_assignments_on_course_instance_id"
    t.index ["deleted_at"], name: "index_assignments_on_deleted_at"
  end

  create_table "course_instances", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.text "description"
    t.bigint "program_id"
    t.bigint "course_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "partner_id"
    t.string "locale", default: "vi", null: false
    t.datetime "deleted_at"
    t.index ["course_id"], name: "index_course_instances_on_course_id"
    t.index ["deleted_at"], name: "index_course_instances_on_deleted_at"
    t.index ["partner_id"], name: "index_course_instances_on_partner_id"
    t.index ["program_id"], name: "index_course_instances_on_program_id"
  end

  create_table "courses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_courses_on_deleted_at"
  end

  create_table "criteria_formats", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "rubric_id"
    t.text "criteria_description"
    t.boolean "mandatory"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "index", default: 0, null: false
    t.decimal "weight", precision: 5, scale: 2, default: "0.0"
    t.string "criteria_type"
    t.string "outcome"
    t.text "meet_the_specification"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_criteria_formats_on_deleted_at"
    t.index ["rubric_id"], name: "index_criteria_formats_on_rubric_id"
  end

  create_table "enrollments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "course_instance_id"
    t.date "start_date"
    t.date "end_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["course_instance_id"], name: "index_enrollments_on_course_instance_id"
    t.index ["deleted_at"], name: "index_enrollments_on_deleted_at"
    t.index ["user_id", "course_instance_id"], name: "index_enrollments_on_user_id_and_course_instance_id", unique: true
    t.index ["user_id"], name: "index_enrollments_on_user_id"
  end

  create_table "graded_criteria", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "graded_rubric_id"
    t.text "criteria_description"
    t.decimal "point", precision: 10
    t.boolean "mandatory"
    t.string "status"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "index", default: 0, null: false
    t.string "criteria_type"
    t.decimal "weight", precision: 5, scale: 2, default: "0.0"
    t.string "outcome"
    t.text "meet_the_specification"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_graded_criteria_on_deleted_at"
    t.index ["graded_rubric_id"], name: "index_graded_criteria_on_graded_rubric_id"
  end

  create_table "graded_rubrics", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.decimal "point", precision: 4, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "comment"
    t.bigint "submission_grade_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_graded_rubrics_on_deleted_at"
    t.index ["submission_grade_id"], name: "index_graded_rubrics_on_submission_grade_id"
  end

  create_table "partners", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "org", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_send_email", default: false, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_partners_on_deleted_at"
  end

  create_table "programs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_programs_on_deleted_at"
  end

  create_table "rubrics", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "assignment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["assignment_id"], name: "index_rubrics_on_assignment_id"
    t.index ["deleted_at"], name: "index_rubrics_on_deleted_at"
  end

  create_table "submission_grades", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "assignment_id"
    t.bigint "student_id"
    t.string "status"
    t.boolean "is_latest"
    t.bigint "mentor_id"
    t.decimal "point", precision: 4, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "assigned_at"
    t.datetime "graded_at"
    t.integer "attempt"
    t.datetime "deleted_at"
    t.string "grade_type"
    t.index ["assignment_id"], name: "index_submission_grades_on_assignment_id"
    t.index ["deleted_at"], name: "index_submission_grades_on_deleted_at"
    t.index ["mentor_id"], name: "index_submission_grades_on_mentor_id"
    t.index ["student_id"], name: "index_submission_grades_on_student_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
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
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object", limit: 4294967295
    t.datetime "created_at"
    t.text "object_changes", limit: 4294967295
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "assignments", "course_instances"
  add_foreign_key "course_instances", "courses"
  add_foreign_key "course_instances", "programs"
  add_foreign_key "criteria_formats", "rubrics"
  add_foreign_key "enrollments", "course_instances"
  add_foreign_key "enrollments", "users"
  add_foreign_key "graded_criteria", "graded_rubrics"
  add_foreign_key "rubrics", "assignments"
  add_foreign_key "submission_grades", "assignments"
end
