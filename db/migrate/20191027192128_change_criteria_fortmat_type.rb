class ChangeCriteriaFortmatType < ActiveRecord::Migration[5.2]
  def up
    change_column :criteria_formats, :weight, :decimal
  end

  def down
    change_column :criteria_formats, :weight, :integer
  end
end
