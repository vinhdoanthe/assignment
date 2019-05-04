class GradedRubric < ApplicationRecord
  belongs_to :rubric
  has_paper_trail on: [:create, :update, :destroy]

end
