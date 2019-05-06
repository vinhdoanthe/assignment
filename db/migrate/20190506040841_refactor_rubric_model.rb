class RefactorRubricModel < ActiveRecord::Migration[5.2]
  def change
    remove_column :rubrics, :cr1_des
    remove_column :rubrics, :cr1_enable
    remove_column :rubrics, :cr1_score

    remove_column :rubrics, :cr2_des
    remove_column :rubrics, :cr2_enable
    remove_column :rubrics, :cr2_score

    remove_column :rubrics, :cr3_des
    remove_column :rubrics, :cr3_enable
    remove_column :rubrics, :cr3_score

    remove_column :rubrics, :cr4_des
    remove_column :rubrics, :cr4_enable
    remove_column :rubrics, :cr4_score

    remove_column :rubrics, :cr5_des
    remove_column :rubrics, :cr5_enable
    remove_column :rubrics, :cr5_score

    remove_column :rubrics, :cr6_des
    remove_column :rubrics, :cr6_enable
    remove_column :rubrics, :cr6_score

    remove_column :rubrics, :cr7_des
    remove_column :rubrics, :cr7_enable
    remove_column :rubrics, :cr7_score

    remove_column :rubrics, :cr8_des
    remove_column :rubrics, :cr8_enable
    remove_column :rubrics, :cr8_score

    remove_column :rubrics, :cr9_des
    remove_column :rubrics, :cr9_enable
    remove_column :rubrics, :cr9_score

    remove_column :rubrics, :cr10_des
    remove_column :rubrics, :cr10_enable
    remove_column :rubrics, :cr10_score

    remove_column :rubrics, :cr11_des
    remove_column :rubrics, :cr11_enable
    remove_column :rubrics, :cr11_score

    remove_column :rubrics, :cr12_des
    remove_column :rubrics, :cr12_enable
    remove_column :rubrics, :cr12_score

    remove_column :rubrics, :cr13_des
    remove_column :rubrics, :cr13_enable
    remove_column :rubrics, :cr13_score

    remove_column :rubrics, :cr14_des
    remove_column :rubrics, :cr14_enable
    remove_column :rubrics, :cr14_score

    remove_column :rubrics, :cr15_des
    remove_column :rubrics, :cr15_enable
    remove_column :rubrics, :cr15_score

    remove_column :rubrics, :cr16_des
    remove_column :rubrics, :cr16_enable
    remove_column :rubrics, :cr16_score

    add_column :rubrics, :description, :text
    # add_column :rubrics, :point, :decimal
    rename_column :rubrics, :rubric_type, :type
  end
end
