require 'test_helper'

class GradedCriteriaControllerTest < ActionDispatch::IntegrationTest
  setup do
    @graded_criterium = graded_criteria(:one)
  end

  test "should get index" do
    get graded_criteria_url
    assert_response :success
  end

  test "should get new" do
    get new_graded_criterium_url
    assert_response :success
  end

  test "should create graded_criterium" do
    assert_difference('GradedCriterium.count') do
      post graded_criteria_url, params: { graded_criterium: { comment: @graded_criterium.comment, description: @graded_criterium.description, graded_rubric_id: @graded_criterium.graded_rubric_id, status: @graded_criterium.status, point: @graded_criterium.point, required: @graded_criterium.required } }
    end

    assert_redirected_to graded_criterium_url(GradedCriterium.last)
  end

  test "should show graded_criterium" do
    get graded_criterium_url(@graded_criterium)
    assert_response :success
  end

  test "should get edit" do
    get edit_graded_criterium_url(@graded_criterium)
    assert_response :success
  end

  test "should update graded_criterium" do
    patch graded_criterium_url(@graded_criterium), params: { graded_criterium: { comment: @graded_criterium.comment, description: @graded_criterium.description, graded_rubric_id: @graded_criterium.graded_rubric_id, status: @graded_criterium.status, point: @graded_criterium.point, required: @graded_criterium.required } }
    assert_redirected_to graded_criterium_url(@graded_criterium)
  end

  test "should destroy graded_criterium" do
    assert_difference('GradedCriterium.count', -1) do
      delete graded_criterium_url(@graded_criterium)
    end

    assert_redirected_to graded_criteria_url
  end
end
