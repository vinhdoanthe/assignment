require "application_system_test_case"

class CourseInstancesTest < ApplicationSystemTestCase
  setup do
    @course_instance = course_instances(:one)
  end

  test "visiting the index" do
    visit course_instances_url
    assert_selector "h1", text: "Course Instances"
  end

  test "creating a Course instance" do
    visit course_instances_url
    click_on "New Course Instance"

    fill_in "Code", with: @course_instance.code
    fill_in "Course", with: @course_instance.course_id
    fill_in "Description", with: @course_instance.description
    fill_in "End date", with: @course_instance.end_date
    fill_in "Name", with: @course_instance.name
    fill_in "Program", with: @course_instance.program_id
    fill_in "Start date", with: @course_instance.start_date
    fill_in "Status", with: @course_instance.status
    click_on "Create Course instance"

    assert_text "Course instance was successfully created"
    click_on "Back"
  end

  test "updating a Course instance" do
    visit course_instances_url
    click_on "Edit", match: :first

    fill_in "Code", with: @course_instance.code
    fill_in "Course", with: @course_instance.course_id
    fill_in "Description", with: @course_instance.description
    fill_in "End date", with: @course_instance.end_date
    fill_in "Name", with: @course_instance.name
    fill_in "Program", with: @course_instance.program_id
    fill_in "Start date", with: @course_instance.start_date
    fill_in "Status", with: @course_instance.status
    click_on "Update Course instance"

    assert_text "Course instance was successfully updated"
    click_on "Back"
  end

  test "destroying a Course instance" do
    visit course_instances_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Course instance was successfully destroyed"
  end
end
