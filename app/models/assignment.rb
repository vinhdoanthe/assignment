class Assignment < ApplicationRecord
  acts_as_paranoid
  extend Enumerize
  include Constants

  validate :validate_constraints
  validates :name, presence: true

  belongs_to :course_instance
  has_one :rubric, inverse_of: :assignment
  has_many :criteria_formats, through: :rubric
  has_paper_trail on: %i[create update destroy]

  enumerize :submit_type, in: [Constants::ASSIGNMENT_SUBMIT_TYPE_FILE,
                               Constants::ASSIGNMENT_SUBMIT_TYPE_NOFILE]
  enumerize :status, in: [Constants::ASSIGNMENT_STATUS_ACTIVE,
                          Constants::ASSIGNMENT_STATUS_INACTIVE]
  enumerize :grade_type, in: [Constants::ASSIGNMENT_GRADE_TYPE_DEFAULT,
                              Constants::ASSIGNMENT_GRADE_TYPE_INTERVIEW]

  def display_name
    "#{course_instance.nil? ? '' : course_instance.code} - #{name}"
  end

  def status_of_learner(user_id)
    submission_grade = SubmissionGrade.where(assignment_id: id,
                                             student_id: user_id,
                                             is_latest: true).first
    if submission_grade.nil?
      Constants::SUBMISSION_GRADE_STATUS_OPEN
    else
      submission_grade.status
    end
  end

  def self.get_passed_criteria(assignment_id, student_id)
    prev_submission_grades = SubmissionGrade.where(assignment_id: assignment_id,
                                                   student_id: student_id)
    passed_criteria = []
    prev_submission_grades.each do |submission|
      passed_criteria += submission.graded_criteriums.select {|criterium| criterium.status == Constants::GRADED_CRITERIA_STATUS_PASSED}
    end
    passed_criteria
  end


  private

  def validate_constraints
    # Todo validate here
  end
end