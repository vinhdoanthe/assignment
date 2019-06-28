# frozen_string_literal: true

class GradedCriterium < ApplicationRecord
  acts_as_paranoid
  extend Enumerize
  include Constants
  before_save :update_status

  belongs_to :graded_rubric

  validates :status, presence: true, if: -> {criteria_type == Constants::CRITERIA_TYPE_PASS_FAIL}
  validates :point, presence: true, if: -> {criteria_type == Constants::CRITERIA_TYPE_POINT}
  validates :comment, presence: true

  enumerize :status, in: [Constants::GRADED_CRITERIA_STATUS_PASSED,
                          Constants::GRADED_CRITERIA_STATUS_FAILED]

  def display_name
    "#{graded_rubric.display_name} - Criteria #{index}"
  end

  def update_status
    if criteria_type == Constants::CRITERIA_TYPE_POINT
      self.status = if point.zero?
                      Constants::GRADED_CRITERIA_STATUS_FAILED
                    else
                      Constants::GRADED_CRITERIA_STATUS_PASSED
                    end
    end
  end

  def can_be_regrade?
    can_be = false
    if criteria_type == Constants::CRITERIA_TYPE_POINT
      can_be = true if point.zero?
    else # Constants::CRITERIA_TYPE_PASS_FAIL
      can_be = true if status == Constants::GRADED_CRITERIA_STATUS_FAILED
    end
    can_be
  end

  def get_status
    temp_status = status
    if criteria_type == Constants::CRITERIA_TYPE_POINT
      temp_status = if point.zero?
                      Constants::GRADED_CRITERIA_STATUS_FAILED
                    else
                      Constants::GRADED_CRITERIA_STATUS_PASSED
                    end
    end
    temp_status
  end
end
