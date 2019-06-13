# frozen_string_literal: true

class GradedRubric < ApplicationRecord
  belongs_to :submission_grade
  has_many :graded_criteriums, dependent: :destroy
  accepts_nested_attributes_for :graded_criteriums
  has_paper_trail on: %i[create update destroy]

  validates :comment, presence: true

  def display_name
    "Graded rubric of #{submission_grade.nil? ? '' : submission_grade.display_name}"
  end

  def status
    graded_criteriums.each do |criterium|
      next unless criterium.mandatory
      if criterium.criteria_type == Constants::CRITERIA_TYPE_PASS_FAIL
        if criterium.status == Constants::GRADED_CRITERIA_STATUS_FAILED
          return Constants::GRADED_RUBRIC_STATUS_FAILED
        end
      else # criteria_type = Constants::CRITERIA_TYPE_POINT
        if criterium.point.zero?
          return Constants::GRADED_RUBRIC_STATUS_FAILED
        end
      end
      Constants::GRADED_CRITERIA_STATUS_PASSED
    end
  end

  def calculate_point!
    temp_point = 0.to_f
    # self.point = 0.to_f
    logger = Rails.logger
    graded_criteriums.each do |criterium|
      if criterium.criteria_type == Constants::CRITERIA_TYPE_PASS_FAIL
        if criterium.status == Constants::GRADED_CRITERIA_STATUS_PASSED
          temp_point += (Settings[:criteria][:pass_fail_point] * criterium.weight).to_f / (submission_grade.assignment.rubric.total_weight).to_f
          logger.info 'temp_point'
          logger.info temp_point
        end
      elsif criterium.criteria_type == Constants::CRITERIA_TYPE_POINT
        temp_point += ((criterium.point.to_f / (Settings[:criteria][:point_max_point]).to_f) * criterium.weight).to_f / (submission_grade.assignment.rubric.total_weight).to_f
        logger.info 'temp_point'
        logger.info temp_point
      end
    end

    temp_point *= Settings[:submission][:point_factor]
    temp_point /= 2 if submission_grade.attempt != 1
    self.point = temp_point.to_d
  end
end
