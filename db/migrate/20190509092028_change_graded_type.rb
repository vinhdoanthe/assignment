class ChangeGradedType < ActiveRecord::Migration[5.2]
  def change
    change_column :graded_criteria, :status, :string
  end
end
