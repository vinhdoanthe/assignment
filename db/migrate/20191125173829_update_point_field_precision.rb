class UpdatePointFieldPrecision < ActiveRecord::Migration[5.2]
  def self.up
    change_column :graded_rubrics, :point, :decimal, :default => 0.0, :precision => 4, :scale => 2
    change_column :submission_grades, :point, :decimal, :default => 0.0, :precision => 4, :scale => 2
  end

  def self.down
    change_column :graded_rubrics, :point, :decimal, :default => 0.0, :precision => 10, :scale => 0
    change_column :submission_grades, :point, :decimal, :default => 0.0, :precision => 10, :scale => 0
  end
end