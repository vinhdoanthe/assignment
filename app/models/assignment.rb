class Assignment < ApplicationRecord
  extend Enumerize
  include Constants

  validate :validate_constraints
  validates :name, presence: true

  belongs_to :course_instance
  has_one :rubric, inverse_of: :assignment
  has_many :criteria_formats, through: :rubric, inverse_of: :assignments

  enumerize :status, in: [Constants::ASSIGNMENT_STATUS_ACTIVE,
                          Constants::ASSIGNMENT_STATUS_INACTIVE]
  enumerize :grade_type, in: [Constants::ASSIGNMENT_GRADE_TYPE_DEFAULT,
                              Constants::ASSIGNMENT_GRADE_TYPE_INTERVIEW]

  def display_name
    "#{self.course_instance.nil? ? '' : self.course_instance.code} - #{self.name}"
  end

  def status_of_learner(user_id)
    submission_grade = SubmissionGrade.where(assignment_id: id,
                                             student_id: user_id,
                                             latest: true).first
    if submission_grade.nil?
      Constants::SUBMISSION_GRADE_STATUS_OPEN
    else
      submission_grade.status
    end
  end

  def self.get_graded_criteria(assignment_id, student_id)
    prev_submission_grades = SubmissionGrade.where(assignment_id: assignment_id, student_id: student_id)
    graded_criteria = []
    prev_submission_grades.each do |submission|
      graded_criteria += submission.graded_criteriums.select {|criterium| criterium.is_passed}
    end
    graded_criteria
  end


  private

  def validate_constraints
    # Todo validate here
  end
end