class Assignment < ApplicationRecord
  extend Enumerize
  include Constants

  validate :validate_constraints
  validates :name, presence: true

  belongs_to :course_instance
  has_one :rubric, :dependent => :destroy, :inverse_of => :assignment
  # attr_accessible :rubric_attributes
  # accepts_nested_attributes_for :rubric, :allow_destroy => true

  has_paper_trail on: [:create, :update, :destroy]

  enumerize :status, in: [Constants::ASSIGNMENT_STATUS_ACTIVE,
                          Constants::ASSIGNMENT_STATUS_INACTIVE]

  def display_name
    "#{self.course_instance.nil?? '' : self.course_instance.code} - #{self.name}"
  end

  def status_of_learner(user_id)
    submission_grade = SubmissionGrade.where(:assignment_id => self.id, :student_id => user_id, :latest => true).first
    if submission_grade.nil?
      Constants::SUBMISSION_GRADE_STATUS_OPEN
    else
      submission_grade.submission_status
    end
  end

  def score_of_learner(userid)
    submission_grade = SubmissionGrade.where(:assignment_id => self.id, :student_id => user_id, :latest => true).first
    if submission_grade.nil?
      'N/A'
    else
      submission_grade.p
    end
  end

  class << self
    def statuses
      {
          Constants::ASSIGNMENT_STATUS_ACTIVE => Constants::ASSIGNMENT_STATUS_ACTIVE,
          Constants::ASSIGNMENT_STATUS_INACTIVE => Constants::ASSIGNMENT_STATUS_INACTIVE
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