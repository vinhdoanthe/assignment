class RemoveTotalWeightSubmissionGrade < ActiveRecord::Migration[5.2]
  def change
    remove_column :submission_grades, :total_weight, :integer
  end
end
