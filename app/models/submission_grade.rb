class SubmissionGrade < ApplicationRecord
  # include SubmissionGradesHelper
  include Constants
  extend Enumerize

  # before_save :update_submision_status

  has_paper_trail on: [:create, :update, :destroy]
  belongs_to :assignment
  belongs_to :student, :class_name => "User", :foreign_key => "student_id"
  belongs_to :mentor, :class_name => "User", :foreign_key => "mentor_id", optional: true
  has_one_attached :submission_file
  has_one_attached :graded_file
  has_one :graded_rubric
  has_many :graded_criteriums, :through => :graded_rubric

  attr_accessor :remove_submission_file
  after_save {submission_file.purge if remove_submission_file == '1'}
  attr_accessor :remove_graded_file
  after_save {graded_file_file.purge if remove_graded_file == '1'}

  accepts_nested_attributes_for :graded_rubric
  # graded_rubric_attributes: [:id, :rubric_id, :description, :rubric_type, :comment]

  enumerize :submission_status, in: [Constants::SUBMISSION_GRADE_STATUS_SUBMITTED,
                                     Constants::SUBMISSION_GRADE_STATUS_ASSIGNED,
                                     Constants::SUBMISSION_GRADE_STATUS_PASSED,
                                     Constants::SUBMISSION_GRADE_STATUS_NOTPASSED]

  def update_submision_status
    if submission_status == Constants::SUBMISSION_GRADE_STATUS_SUBMITTED && (mentor_id != 0)
      submission_status == Constants::SUBMISSION_GRADE_STATUS_ASSIGNED
    end
  end
end
