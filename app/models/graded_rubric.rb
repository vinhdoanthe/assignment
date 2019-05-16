# frozen_string_literal: true

class GradedRubric < ApplicationRecord
  belongs_to :submission_grade
  has_many :graded_criteriums, dependent: :destroy

  has_paper_trail on: %i[create update destroy]

  accepts_nested_attributes_for :graded_criteriums

  def display_name
    "Graded rubric of #{submission_grade.nil? ? '' : submission_grade.display_name}"
  end

  def get_status
    temp_status = Constants::GRADED_CRITERIA_STATUS_PASSED

    graded_criteriums.each do |criterium|
      next unless criterium.is_required

      if criterium.criteria_type == Constants::CRITERIA_TYPE_PASS_FAIL
        if criterium.status == Constants::GRADED_CRITERIA_STATUS_FAILED
          temp_status = Constants::GRADED_RUBRIC_STATUS_FAILED
          return temp_status
        end
      else # criterium.status == CRITERIA_TYPE_POINT
        if criterium.point <= 0
          temp_status = Constants::GRADED_RUBRIC_STATUS_FAILED
          return temp_status
        end
      end
    end

    temp_status
  end

  def calculate_point!
    self.point = 0

    graded_criteriums.each do |criterium|
      if criterium.criteria_type == Constants::CRITERIA_TYPE_PASS_FAIL
        if criterium.status == Constants::GRADED_CRITERIA_STATUS_PASSED
          if submission_grade.attempt == 1
            self.point += (Settings[:criteria][:pass_fail_point] * criterium.weight) / submission_grade.assignment.rubric.total_weight
          else
            self.point += (Settings[:criteria][:pass_fail_point] * criterium.weight / 2) / submission_grade.assignment.rubric.total_weight
          end
        end
      elsif criterium.criteria_type == Constants::CRITERIA_TYPE_POINT
        if submission_grade.attempt == 1
          self.point += ((criterium.point / Settings[:criteria][:point_max_point]) * criterium.weight) / submission_grade.assignment.rubric.total_weight
        else
          self.point += ((criterium.point / Settings[:criteria][:point_max_point]) * criterium.weight / 2) / submission_grade.assignment.rubric.total_weight
        end
      end
    end

    self.point *= Settings[:submission][:point_factor]
  end
end
