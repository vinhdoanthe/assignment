# frozen_string_literal: true

class GradedRubric < ApplicationRecord
  belongs_to :submission_grade
  has_many :graded_criteriums, dependent: :destroy

  has_paper_trail on: %i[create update destroy]

  accepts_nested_attributes_for :graded_criteriums

  def display_name
    "Graded rubric of #{submission_grade.nil? ? '' : submission_grade.display_name}"
  end

  def status
    graded_criteriums.& each do |criterium|
      if criterium.is_required
        if criterium.status != Constants::GRADED_CRITERIA_STATUS_FAILED
          return Constants::GRADED_RUBRIC_STATUS_FAILED
        end
      end
    end
    Constants::GRADED_CRITERIA_STATUS_PASSED
  end
end
