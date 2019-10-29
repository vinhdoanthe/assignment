class UpdateWeightFieldTypes < ActiveRecord::Migration[5.2]
  def up
    change_column :criteria_formats, :weight, :decimal, :precision => 4, :scale => 2, :default => 0.00
    change_column :graded_criteria, :weight, :decimal, :precision => 4, :scale => 2, :default => 0.00
  end

  def down
    change_column :criteria_formats, :weight, :decimal
    change_column :graded_criteria, :weight, :decimal
  end
end
