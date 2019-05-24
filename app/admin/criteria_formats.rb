ActiveAdmin.register CriteriaFormat do

  belongs_to :rubric

  permit_params :index, :criteria_description,
                :outcome, :meet_the_specification,
                :weight, :mandatory, :criteria_type
end
