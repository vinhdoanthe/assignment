ActiveAdmin.register GradedCriterium do

  menu false

  controller do
    belongs_to :graded_rubric, optional: true
  end

  permit_params :graded_rubric_id, :index, :description, :status, :comment, :is_required, :criteria_type, :point, :weight
end
