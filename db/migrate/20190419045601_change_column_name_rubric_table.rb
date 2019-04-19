class ChangeColumnNameRubricTable < ActiveRecord::Migration[5.2]
  def change
    rename_column :rubrics, :type, :rubric_type
  end
end
