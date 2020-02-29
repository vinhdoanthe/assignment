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

  def list_graded_rubrics(submission_grade)
    submission_grades = SubmissionGrade.where(student_id: submission_grade.student_id, assignment_id: submission_grade.assignment_id)
    graded_rubrics = []
    if submission_grades.nil?
      nil
    else
      submission_grades.each do |submission|
        unless submission.graded_rubric.nil?
          graded_rubrics.append submission.graded_rubric
        end
      end
      graded_rubrics
    end
  end

  def count_assigned_submissions(course_instance_id, mentor_id)
    assignments = CourseInstance.find(course_instance_id).assignments
    count = 0
    unless assignments.nil?
      assignments.each do |assignment|
        count += SubmissionGrade.where(mentor_id: mentor_id, assignment_id: assignment.id, status: Constants::SUBMISSION_GRADE_STATUS_ASSIGNED).count
      end
    end
    count
  end

  def count_graded_submissions(course_instance_id, mentor_id)
    0
  end

  def need_interview?(submission_id)
    submission = SubmissionGrade.find(submission_id)
    if submission.grade_type == Constants::ASSIGNMENT_GRADE_TYPE_INTERVIEW
      need_review = true
      unless submission.nil? || submission.attempt == 1
        assignment_id = submission.assignment_id
        student_id = submission.student_id
        submissions = SubmissionGrade.where(assignment_id: assignment_id, student_id: student_id).to_a
        unless submissions.blank?
          submissions.each do |submission|
            if !submission.point.nil? && submission.point != 0
              need_review = false
              break
            end
          end
        end
      end
      need_review
    else
      false
    end

  end
end
