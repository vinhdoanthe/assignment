class GradedCriterium < ApplicationRecord
  extend Enumerize
  include Constants

  belongs_to :graded_rubric

  validates :index, presence: true, uniqueness: {scope: :graded_rubric_id, message: 'Criteria already existed'}
  validates :status, presence: true
  attribute :status, default: Constants::GRADED_CRITERIA_STATUS_NOTGRADED

  enumerize :status, in: [Constants::GRADED_CRITERIA_STATUS_NOTGRADED,
                          Constants::GRADED_CRITERIA_STATUS_PASSED,
                          Constants::GRADED_CRITERIA_STATUS_FAILED]

  def display_name
    "#{graded_rubric.display_name} - Criteria #{index}"
  end

  def update_status
    if criteria_type == Constants::CRITERIA_TYPE_POINT
      self.point /= Constants::CRITERIA_MAX_POINT
      self.status = if self.point.zero?
                      Constants::GRADED_CRITERIA_STATUS_FAILED
                    else
                      Constants::GRADED_CRITERIA_STATUS_PASSED
                    end
    elsif status != Constants::GRADED_CRITERIA_STATUS_NOTGRADED
      self.point = status == Constants::GRADED_CRITERIA_STATUS_PASSED ? 1 : 0
    else
      self.point = 0
      self.status = Constants::GRADED_RUBRIC_STATUS_FAILED
    end
  end

end