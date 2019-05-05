class SubmissionGrade < ApplicationRecord
  include SubmissionGradesHelper
  extend Enumerize

  # include Constants
  has_paper_trail on: [:create, :update, :destroy]
  belongs_to :assignment
  belongs_to :student, :class_name => "User", :foreign_key => "student_id"
  # belongs_to :submission_file
  belongs_to :mentor, :class_name => "User", :foreign_key => "mentor_id", optional: true
  # belongs_to :graded_rubric, optional: true
  # belongs_to :graded_file
  has_one_attached :submission_file
  has_one_attached :graded_file
  has_one :graded_rubric

  attr_accessor :remove_submission_file
  after_save {submission_file.purge if remove_submission_file == '1'}
  attr_accessor :remove_graded_file
  after_save {graded_file_file.purge if remove_graded_file == '1'}

  enumerize :submission_status, in: [Constants::SUBMISSION_GRADE_STATUS_SUBMITTED,
                                     Constants::SUBMISSION_GRADE_STATUS_ASSIGNED,
                                     Constants::SUBMISSION_GRADE_STATUS_PASSED,
                                     Constants::SUBMISSION_GRADE_STATUS_NOTPASSED]
end
