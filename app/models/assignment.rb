class Assignment < ApplicationRecord
  include Constants
  belongs_to :course_instance
  has_one :rubric

  validate :validate_constraints

  def status_of_learner(user_id)
    submission_grade = SubmissionGrade.where(:assignment_id => self.id, :student_id => user_id, :latest => true).first
    if submission_grade.nil?
      Constants::SUBMISSION_GRADE_STATUS_OPEN
    else
      submission_grade.submission_status
    end
  end

  class << self
    def assignment_status
      statuses = {
          'active' => 'active',
          'inactive' => 'inactive'
      }
    end
  end

  private

  def validate_constraints
    if end_date < start_date
      errors.add(:start_date, 'End date must be after Start date')
    end
  end
end
