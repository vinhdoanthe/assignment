class AddPassFieldToGradedRubric < ActiveRecord::Migration[5.2]
  def change
    add_column :graded_rubrics, :cr1_passed, :boolean
    add_column :graded_rubrics, :cr2_passed, :boolean
    add_column :graded_rubrics, :cr3_passed, :boolean
    add_column :graded_rubrics, :cr4_passed, :boolean
    add_column :graded_rubrics, :cr5_passed, :boolean
    add_column :graded_rubrics, :cr6_passed, :boolean
    add_column :graded_rubrics, :cr7_passed, :boolean
    add_column :graded_rubrics, :cr8_passed, :boolean
    add_column :graded_rubrics, :cr9_passed, :boolean
    add_column :graded_rubrics, :cr10_passed, :boolean
    add_column :graded_rubrics, :cr11_passed, :boolean
    add_column :graded_rubrics, :cr12_passed, :boolean
    add_column :graded_rubrics, :cr13_passed, :boolean
    add_column :graded_rubrics, :cr14_passed, :boolean
    add_column :graded_rubrics, :cr15_passed, :boolean
    add_column :graded_rubrics, :cr16_passed, :boolean
    add_reference :graded_rubrics, :submission_grade
  end
end
