class UpdateCriteriaSubmission < ActiveRecord::Migration[5.2]
  def change
    add_column :submission_grades, :total_weight, :integer
    remove_column :criteria_formats, :point
  end
end
