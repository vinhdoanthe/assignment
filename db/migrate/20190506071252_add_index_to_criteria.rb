class AddIndexToCriteria < ActiveRecord::Migration[5.2]
  def change
    add_column :graded_criteria, :index, :integer, null: false, default: 0
    add_column :criteria_formats, :index, :integer, null: false, default: 0
  end
end
