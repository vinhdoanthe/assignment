class UpdateCriteriaFormat < ActiveRecord::Migration[5.2]
  def change
    rename_column :criteria_formats, :point, :max_point
    add_column :criteria_formats, :weighted, :integer, :default => 0
    add_column :criteria_formats, :criteria_type, :string
  end
end
