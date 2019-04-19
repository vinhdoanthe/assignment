class AddCommentsToGradedRubricModel < ActiveRecord::Migration[5.2]
  def change
    add_column :graded_rubrics, :cr1_comment, :text
    add_column :graded_rubrics, :cr2_comment, :text
    add_column :graded_rubrics, :cr3_comment, :text
    add_column :graded_rubrics, :cr4_comment, :text
    add_column :graded_rubrics, :cr5_comment, :text
    add_column :graded_rubrics, :cr6_comment, :text
    add_column :graded_rubrics, :cr7_comment, :text
    add_column :graded_rubrics, :cr8_comment, :text
    add_column :graded_rubrics, :cr9_comment, :text
    add_column :graded_rubrics, :cr10_comment, :text
    add_column :graded_rubrics, :cr11_comment, :text
    add_column :graded_rubrics, :cr12_comment, :text
    add_column :graded_rubrics, :cr13_comment, :text
    add_column :graded_rubrics, :cr14_comment, :text
    add_column :graded_rubrics, :cr15_comment, :text
    add_column :graded_rubrics, :cr16_comment, :text
    add_column :graded_rubrics, :comment, :text
  end
end
