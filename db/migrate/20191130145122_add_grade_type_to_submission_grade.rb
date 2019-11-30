class AddGradeTypeToSubmissionGrade < ActiveRecord::Migration[5.2]
  def up
    add_column :submission_grades, :grade_type, :string
  end

  def down
    remove_column :submission_grades, :grade_type
  end
end
