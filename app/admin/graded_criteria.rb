ActiveAdmin.register GradedCriterium do

  menu false

  controller do
    belongs_to :graded_rubric, optional: true
  end

  permit_params :graded_rubric_id, :index, :criteria_description,
                :outcome, :meet_the_specification, :status, :comment,
                :mandatory, :criteria_type, :point, :weight
end
