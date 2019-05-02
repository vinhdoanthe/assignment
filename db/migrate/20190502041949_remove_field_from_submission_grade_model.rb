class RemoveFieldFromSubmissionGradeModel < ActiveRecord::Migration[5.2]
  def change
    remove_column :submission_grades, :grade_status
  end
end
