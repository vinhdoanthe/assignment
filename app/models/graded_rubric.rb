# frozen_string_literal: true

class GradedRubric < ApplicationRecord
  belongs_to :submission_grade
  has_many :graded_criteriums

  has_paper_trail on: %i[create update destroy]

  accepts_nested_attributes_for :graded_criteriums

  def display_name
    submission_grade.nil? ? '' : submission_grade.assignment.display_name
  end
end
