class UpdateDefaultPointOfSubmissionGradeToNil < ActiveRecord::Migration[5.2]
  def up
    change_column :submission_grades, :point, :decimal, :precision => 4, :scale => 2, :default => nil
  end

  def down
    change_column :submission_grades, :point, :decimal, :precision => 4, :scale => 2, :default => 0.0
  end
end
