class AddSoftDeleted < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :deleted_at, :datetime
    add_index :assignments, :deleted_at
    add_column :course_instances, :deleted_at, :datetime
    add_index :course_instances, :deleted_at
    add_column :courses, :deleted_at, :datetime
    add_index :courses, :deleted_at
    add_column :criteria_formats, :deleted_at, :datetime
    add_index :criteria_formats, :deleted_at
    add_column :enrollments, :deleted_at, :datetime
    add_index :enrollments, :deleted_at
    add_column :graded_criteria, :deleted_at, :datetime
    add_index :graded_criteria, :deleted_at
    add_column :graded_rubrics, :deleted_at, :datetime
    add_index :graded_rubrics, :deleted_at
    add_column :partners, :deleted_at, :datetime
    add_index :partners, :deleted_at
    add_column :rubrics, :deleted_at, :datetime
    add_index :rubrics, :deleted_at
    add_column :submission_grades, :deleted_at, :datetime
    add_index :submission_grades, :deleted_at
    add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at
    add_column :programs, :deleted_at, :datetime
    add_index :programs, :deleted_at
  end
end
