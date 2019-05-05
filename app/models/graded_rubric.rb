class GradedRubric < ApplicationRecord
  belongs_to :rubric
  belongs_to :submission_grade, optional: true
  has_paper_trail on: [:create, :update, :destroy]
end
