require "application_system_test_case"

class SubmissionGradesTest < ApplicationSystemTestCase
  setup do
    @submission_grade = submission_grades(:one)
  end

  test "visiting the index" do
    visit submission_grades_url
    assert_selector "h1", text: "Submission Grades"
  end

  test "creating a Submission grade" do
    visit submission_grades_url
    click_on "New Submission Grade"

    fill_in "Assignment", with: @submission_grade.assignment_id
    fill_in "Attempt count", with: @submission_grade.is_latest
    fill_in "Grade status", with: @submission_grade.grade_status
    fill_in "Graded file", with: @submission_grade.graded_file_id
    fill_in "Graded rubric", with: @submission_grade.graded_rubric_id
    check "Latest" if @submission_grade.is_latest
    fill_in "Mentor", with: @submission_grade.mentor_id
    fill_in "Point", with: @submission_grade.point
    fill_in "Student", with: @submission_grade.student_id
    fill_in "Submission file", with: @submission_grade.submission_file_id
    fill_in "Submission status", with: @submission_grade.status
    click_on "Create Submission grade"

    assert_text "Submission grade was successfully created"
    click_on "Back"
  end

  test "updating a Submission grade" do
    visit submission_grades_url
    click_on "Edit", match: :first

    fill_in "Assignment", with: @submission_grade.assignment_id
    fill_in "Attempt count", with: @submission_grade.is_latest
    fill_in "Grade status", with: @submission_grade.grade_status
    fill_in "Graded file", with: @submission_grade.graded_file_id
    fill_in "Graded rubric", with: @submission_grade.graded_rubric_id
    check "Latest" if @submission_grade.is_latest
    fill_in "Mentor", with: @submission_grade.mentor_id
    fill_in "Point", with: @submission_grade.point
    fill_in "Student", with: @submission_grade.student_id
    fill_in "Submission file", with: @submission_grade.submission_file_id
    fill_in "Submission status", with: @submission_grade.status
    click_on "Update Submission grade"

    assert_text "Submission grade was successfully updated"
    click_on "Back"
  end

  test "destroying a Submission grade" do
    visit submission_grades_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Submission grade was successfully destroyed"
  end
end
