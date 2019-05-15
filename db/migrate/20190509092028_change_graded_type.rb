class ChangeGradedType < ActiveRecord::Migration[5.2]
  def change
    rename_column :graded_criteria, :status, :status
    change_column :graded_criteria, :status, :string
  end
end
