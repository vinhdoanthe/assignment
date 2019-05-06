class RefactorGradedRubricModel < ActiveRecord::Migration[5.2]
  def change
    remove_column :graded_rubrics, :cr1_des
    remove_column :graded_rubrics, :cr1_enable
    remove_column :graded_rubrics, :cr1_score

    remove_column :graded_rubrics, :cr2_des
    remove_column :graded_rubrics, :cr2_enable
    remove_column :graded_rubrics, :cr2_score

    remove_column :graded_rubrics, :cr3_des
    remove_column :graded_rubrics, :cr3_enable
    remove_column :graded_rubrics, :cr3_score

    remove_column :graded_rubrics, :cr4_des
    remove_column :graded_rubrics, :cr4_enable
    remove_column :graded_rubrics, :cr4_score

    remove_column :graded_rubrics, :cr5_des
    remove_column :graded_rubrics, :cr5_enable
    remove_column :graded_rubrics, :cr5_score

    remove_column :graded_rubrics, :cr6_des
    remove_column :graded_rubrics, :cr6_enable
    remove_column :graded_rubrics, :cr6_score

    remove_column :graded_rubrics, :cr7_des
    remove_column :graded_rubrics, :cr7_enable
    remove_column :graded_rubrics, :cr7_score

    remove_column :graded_rubrics, :cr8_des
    remove_column :graded_rubrics, :cr8_enable
    remove_column :graded_rubrics, :cr8_score

    remove_column :graded_rubrics, :cr9_des
    remove_column :graded_rubrics, :cr9_enable
    remove_column :graded_rubrics, :cr9_score

    remove_column :graded_rubrics, :cr10_des
    remove_column :graded_rubrics, :cr10_enable
    remove_column :graded_rubrics, :cr10_score

    remove_column :graded_rubrics, :cr11_des
    remove_column :graded_rubrics, :cr11_enable
    remove_column :graded_rubrics, :cr11_score

    remove_column :graded_rubrics, :cr12_des
    remove_column :graded_rubrics, :cr12_enable
    remove_column :graded_rubrics, :cr12_score

    remove_column :graded_rubrics, :cr13_des
    remove_column :graded_rubrics, :cr13_enable
    remove_column :graded_rubrics, :cr13_score

    remove_column :graded_rubrics, :cr14_des
    remove_column :graded_rubrics, :cr14_enable
    remove_column :graded_rubrics, :cr14_score

    remove_column :graded_rubrics, :cr15_des
    remove_column :graded_rubrics, :cr15_enable
    remove_column :graded_rubrics, :cr15_score

    remove_column :graded_rubrics, :cr16_des
    remove_column :graded_rubrics, :cr16_enable
    remove_column :graded_rubrics, :cr16_score

    remove_column :graded_rubrics, :cr1_passed
    remove_column :graded_rubrics, :cr1_comment

    remove_column :graded_rubrics, :cr2_passed
    remove_column :graded_rubrics, :cr2_comment

    remove_column :graded_rubrics, :cr3_passed
    remove_column :graded_rubrics, :cr3_comment

    remove_column :graded_rubrics, :cr4_passed
    remove_column :graded_rubrics, :cr4_comment

    remove_column :graded_rubrics, :cr5_passed
    remove_column :graded_rubrics, :cr5_comment

    remove_column :graded_rubrics, :cr6_passed
    remove_column :graded_rubrics, :cr6_comment

    remove_column :graded_rubrics, :cr7_passed
    remove_column :graded_rubrics, :cr7_comment

    remove_column :graded_rubrics, :cr8_passed
    remove_column :graded_rubrics, :cr8_comment

    remove_column :graded_rubrics, :cr9_passed
    remove_column :graded_rubrics, :cr9_comment

    remove_column :graded_rubrics, :cr10_passed
    remove_column :graded_rubrics, :cr10_comment

    remove_column :graded_rubrics, :cr11_passed
    remove_column :graded_rubrics, :cr11_comment

    remove_column :graded_rubrics, :cr12_passed
    remove_column :graded_rubrics, :cr12_comment

    remove_column :graded_rubrics, :cr13_passed
    remove_column :graded_rubrics, :cr13_comment

    remove_column :graded_rubrics, :cr14_passed
    remove_column :graded_rubrics, :cr14_comment

    remove_column :graded_rubrics, :cr15_passed
    remove_column :graded_rubrics, :cr15_comment

    remove_column :graded_rubrics, :cr16_passed
    remove_column :graded_rubrics, :cr16_comment

    rename_column :graded_rubrics, :type, :rubric_type
    add_column :graded_rubrics, :description, :text
  end
end
