class GradedRubric < ApplicationRecord
  belongs_to :rubric
  belongs_to :submission_grade, optional: true
  has_paper_trail on: [:create, :update, :destroy]
  has_many :graded_criteriums

  def display_name
    submission_grade.assignment.display_name
  end
end
