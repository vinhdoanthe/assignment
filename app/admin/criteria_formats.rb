ActiveAdmin.register CriteriaFormat do
  # controller do
  belongs_to :rubric
  # end

  permit_params :index, :description, :weight, :is_required, :criteria_type
end
