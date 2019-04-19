require 'test_helper'

class CourseInstancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_instance = course_instances(:one)
  end

  test "should get index" do
    get course_instances_url
    assert_response :success
  end

  test "should get new" do
    get new_course_instance_url
    assert_response :success
  end

  test "should create course_instance" do
    assert_difference('CourseInstance.count') do
      post course_instances_url, params: { course_instance: { code: @course_instance.code, course_id: @course_instance.course_id, description: @course_instance.description, end_date: @course_instance.end_date, name: @course_instance.name, program_id: @course_instance.program_id, start_date: @course_instance.start_date, status: @course_instance.status } }
    end

    assert_redirected_to course_instance_url(CourseInstance.last)
  end

  test "should show course_instance" do
    get course_instance_url(@course_instance)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_instance_url(@course_instance)
    assert_response :success
  end

  test "should update course_instance" do
    patch course_instance_url(@course_instance), params: { course_instance: { code: @course_instance.code, course_id: @course_instance.course_id, description: @course_instance.description, end_date: @course_instance.end_date, name: @course_instance.name, program_id: @course_instance.program_id, start_date: @course_instance.start_date, status: @course_instance.status } }
    assert_redirected_to course_instance_url(@course_instance)
  end

  test "should destroy course_instance" do
    assert_difference('CourseInstance.count', -1) do
      delete course_instance_url(@course_instance)
    end

    assert_redirected_to course_instances_url
  end
end
