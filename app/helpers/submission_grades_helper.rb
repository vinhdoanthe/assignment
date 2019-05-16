# frozen_string_literal: true

module SubmissionGradesHelper
  include Constants

  def student_can_submit?(assignment_id, user_id)
    # Define logic for check if a student is accepted for submitting the assignment
    # enrollments = Enrollment.where(:user_id => user_id, :is_active => true)
    # Step 1: check enrollment
    # TODO TODO
    # Step 2: check previous submission
    last_submission_grade = SubmissionGrade.where(assignment_id: assignment_id, student_id: user_id, is_latest: true).first
    if last_submission_grade.nil? ||
       (last_submission_grade.status == Constants::SUBMISSION_GRADE_STATUS_NOT_PASSED &&
           (Assignment.find(assignment_id).max_attempt.zero? ? true : last_submission_grade.attempt < Assignment.find(assignment_id).max_attempt))
      true
    else
      false
    end
  end

  def find_attempt(assignment_id, user_id)
    sub_grade = SubmissionGrade.where(assignment_id: assignment_id, student_id: user_id, is_latest: true).first
    if sub_grade.nil?
      1
    else
      sub_grade.attempt + 1
    end
  end
end
