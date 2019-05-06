require 'test_helper'

class CriteriaFormatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @criteria_format = criteria_formats(:one)
  end

  test "should get index" do
    get criteria_formats_url
    assert_response :success
  end

  test "should get new" do
    get new_criteria_format_url
    assert_response :success
  end

  test "should create criteria_format" do
    assert_difference('CriteriaFormat.count') do
      post criteria_formats_url, params: { criteria_format: { description: @criteria_format.description, point: @criteria_format.point, required: @criteria_format.required, rubric_id: @criteria_format.rubric_id } }
    end

    assert_redirected_to criteria_format_url(CriteriaFormat.last)
  end

  test "should show criteria_format" do
    get criteria_format_url(@criteria_format)
    assert_response :success
  end

  test "should get edit" do
    get edit_criteria_format_url(@criteria_format)
    assert_response :success
  end

  test "should update criteria_format" do
    patch criteria_format_url(@criteria_format), params: { criteria_format: { description: @criteria_format.description, point: @criteria_format.point, required: @criteria_format.required, rubric_id: @criteria_format.rubric_id } }
    assert_redirected_to criteria_format_url(@criteria_format)
  end

  test "should destroy criteria_format" do
    assert_difference('CriteriaFormat.count', -1) do
      delete criteria_format_url(@criteria_format)
    end

    assert_redirected_to criteria_formats_url
  end
end
