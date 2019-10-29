class UpdateWeightFields < ActiveRecord::Migration[5.2]
  def change
    def up
      change_column :criteria_formats, :weight, :decimal, precision: 10, scale: 2, default: 0.0
    end

    def down
      change_column :criteria_formats, :weight, :decimal, default: 0.0
    end
  end
end
