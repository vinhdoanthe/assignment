class AddAttempToSubmissionGrade < ActiveRecord::Migration[5.2]
  def change
    add_column :submission_grades, :attempt, :integer
  end
end
