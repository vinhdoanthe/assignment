class SubmissionGrade < ApplicationRecord
  belongs_to :assignment
  belongs_to :student
  belongs_to :submission_file
  belongs_to :mentor
  belongs_to :graded_rubric
  belongs_to :graded_file
end
