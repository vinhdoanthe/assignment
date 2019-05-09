require 'test_helper'

class SubmissionGradesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @submission_grade = submission_grades(:one)
  end

  test "should get index" do
    get submission_grades_url
    assert_response :success
  end

  test "should get new" do
    get new_submission_grade_url
    assert_response :success
  end

  test "should create submission_grade" do
    assert_difference('SubmissionGrade.count') do
      post submission_grades_url, params: { submission_grade: { assignment_id: @submission_grade.assignment_id, is_latest: @submission_grade.is_latest, grade_status: @submission_grade.grade_status, graded_file_id: @submission_grade.graded_file_id, graded_rubric_id: @submission_grade.graded_rubric_id, is_latest: @submission_grade.is_latest, mentor_id: @submission_grade.mentor_id, point: @submission_grade.point, student_id: @submission_grade.student_id, submission_file_id: @submission_grade.submission_file_id, status: @submission_grade.status } }
    end

    assert_redirected_to submission_grade_url(SubmissionGrade.last)
  end

  test "should show submission_grade" do
    get submission_grade_url(@submission_grade)
    assert_response :success
  end

  test "should get edit" do
    get edit_submission_grade_url(@submission_grade)
    assert_response :success
  end

  test "should update submission_grade" do
    patch submission_grade_url(@submission_grade), params: { submission_grade: { assignment_id: @submission_grade.assignment_id, is_latest: @submission_grade.is_latest, grade_status: @submission_grade.grade_status, graded_file_id: @submission_grade.graded_file_id, graded_rubric_id: @submission_grade.graded_rubric_id, is_latest: @submission_grade.is_latest, mentor_id: @submission_grade.mentor_id, point: @submission_grade.point, student_id: @submission_grade.student_id, submission_file_id: @submission_grade.submission_file_id, status: @submission_grade.status } }
    assert_redirected_to submission_grade_url(@submission_grade)
  end

  test "should destroy submission_grade" do
    assert_difference('SubmissionGrade.count', -1) do
      delete submission_grade_url(@submission_grade)
    end

    assert_redirected_to submission_grades_url
  end
end
