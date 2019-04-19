class DropColumnsSubmissionGradesTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :submission_grades, :submission_file_id
    remove_column :submission_grades, :graded_file_id 
  end
end
