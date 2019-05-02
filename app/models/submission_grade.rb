class SubmissionGrade < ApplicationRecord
  include SubmissionGradesHelper
  # include Constants
  belongs_to :assignment
  belongs_to :student, :class_name => "User", :foreign_key => "student_id"
  # belongs_to :submission_file
  belongs_to :mentor, :class_name => "User", :foreign_key => "mentor_id", optional: true
  belongs_to :graded_rubric, optional: true
  # belongs_to :graded_file
  has_one_attached :submission_file
  has_one_attached :graded_file
end
