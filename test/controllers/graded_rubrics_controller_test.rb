require 'test_helper'

class GradedRubricsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @graded_rubric = graded_rubrics(:one)
  end

  test "should get index" do
    get graded_rubrics_url
    assert_response :success
  end

  test "should get new" do
    get new_graded_rubric_url
    assert_response :success
  end

  test "should create graded_rubric" do
    assert_difference('GradedRubric.count') do
      post graded_rubrics_url, params: { graded_rubric: { cr10_des: @graded_rubric.cr10_des, cr10_enable: @graded_rubric.cr10_enable, cr10_score: @graded_rubric.cr10_score, cr11_des: @graded_rubric.cr11_des, cr11_enable: @graded_rubric.cr11_enable, cr11_score: @graded_rubric.cr11_score, cr12_des: @graded_rubric.cr12_des, cr12_enable: @graded_rubric.cr12_enable, cr12_score: @graded_rubric.cr12_score, cr13_des: @graded_rubric.cr13_des, cr13_enable: @graded_rubric.cr13_enable, cr13_score: @graded_rubric.cr13_score, cr14_des: @graded_rubric.cr14_des, cr14_enable: @graded_rubric.cr14_enable, cr14_score: @graded_rubric.cr14_score, cr15_des: @graded_rubric.cr15_des, cr15_enable: @graded_rubric.cr15_enable, cr15_score: @graded_rubric.cr15_score, cr16_des: @graded_rubric.cr16_des, cr16_enable: @graded_rubric.cr16_enable, cr16_score: @graded_rubric.cr16_score, cr1_des: @graded_rubric.cr1_des, cr1_enable: @graded_rubric.cr1_enable, cr1_score: @graded_rubric.cr1_score, cr2_des: @graded_rubric.cr2_des, cr2_enable: @graded_rubric.cr2_enable, cr2_score: @graded_rubric.cr2_score, cr3_des: @graded_rubric.cr3_des, cr3_enable: @graded_rubric.cr3_enable, cr3_score: @graded_rubric.cr3_score, cr4_des: @graded_rubric.cr4_des, cr4_enable: @graded_rubric.cr4_enable, cr4_score: @graded_rubric.cr4_score, cr5_des: @graded_rubric.cr5_des, cr5_enable: @graded_rubric.cr5_enable, cr5_score: @graded_rubric.cr5_score, cr6_des: @graded_rubric.cr6_des, cr6_enable: @graded_rubric.cr6_enable, cr6_score: @graded_rubric.cr6_score, cr7_des: @graded_rubric.cr7_des, cr7_enable: @graded_rubric.cr7_enable, cr7_score: @graded_rubric.cr7_score, cr8_des: @graded_rubric.cr8_des, cr8_enable: @graded_rubric.cr8_enable, cr8_score: @graded_rubric.cr8_score, cr9_des: @graded_rubric.cr9_des, cr9_enable: @graded_rubric.cr9_enable, cr9_score: @graded_rubric.cr9_score, point: @graded_rubric.point, rubric_id: @graded_rubric.rubric_id, status: @graded_rubric.status, type: @graded_rubric.type } }
    end

    assert_redirected_to graded_rubric_url(GradedRubric.last)
  end

  test "should show graded_rubric" do
    get graded_rubric_url(@graded_rubric)
    assert_response :success
  end

  test "should get edit" do
    get edit_graded_rubric_url(@graded_rubric)
    assert_response :success
  end

  test "should update graded_rubric" do
    patch graded_rubric_url(@graded_rubric), params: { graded_rubric: { cr10_des: @graded_rubric.cr10_des, cr10_enable: @graded_rubric.cr10_enable, cr10_score: @graded_rubric.cr10_score, cr11_des: @graded_rubric.cr11_des, cr11_enable: @graded_rubric.cr11_enable, cr11_score: @graded_rubric.cr11_score, cr12_des: @graded_rubric.cr12_des, cr12_enable: @graded_rubric.cr12_enable, cr12_score: @graded_rubric.cr12_score, cr13_des: @graded_rubric.cr13_des, cr13_enable: @graded_rubric.cr13_enable, cr13_score: @graded_rubric.cr13_score, cr14_des: @graded_rubric.cr14_des, cr14_enable: @graded_rubric.cr14_enable, cr14_score: @graded_rubric.cr14_score, cr15_des: @graded_rubric.cr15_des, cr15_enable: @graded_rubric.cr15_enable, cr15_score: @graded_rubric.cr15_score, cr16_des: @graded_rubric.cr16_des, cr16_enable: @graded_rubric.cr16_enable, cr16_score: @graded_rubric.cr16_score, cr1_des: @graded_rubric.cr1_des, cr1_enable: @graded_rubric.cr1_enable, cr1_score: @graded_rubric.cr1_score, cr2_des: @graded_rubric.cr2_des, cr2_enable: @graded_rubric.cr2_enable, cr2_score: @graded_rubric.cr2_score, cr3_des: @graded_rubric.cr3_des, cr3_enable: @graded_rubric.cr3_enable, cr3_score: @graded_rubric.cr3_score, cr4_des: @graded_rubric.cr4_des, cr4_enable: @graded_rubric.cr4_enable, cr4_score: @graded_rubric.cr4_score, cr5_des: @graded_rubric.cr5_des, cr5_enable: @graded_rubric.cr5_enable, cr5_score: @graded_rubric.cr5_score, cr6_des: @graded_rubric.cr6_des, cr6_enable: @graded_rubric.cr6_enable, cr6_score: @graded_rubric.cr6_score, cr7_des: @graded_rubric.cr7_des, cr7_enable: @graded_rubric.cr7_enable, cr7_score: @graded_rubric.cr7_score, cr8_des: @graded_rubric.cr8_des, cr8_enable: @graded_rubric.cr8_enable, cr8_score: @graded_rubric.cr8_score, cr9_des: @graded_rubric.cr9_des, cr9_enable: @graded_rubric.cr9_enable, cr9_score: @graded_rubric.cr9_score, point: @graded_rubric.point, rubric_id: @graded_rubric.rubric_id, status: @graded_rubric.status, type: @graded_rubric.type } }
    assert_redirected_to graded_rubric_url(@graded_rubric)
  end

  test "should destroy graded_rubric" do
    assert_difference('GradedRubric.count', -1) do
      delete graded_rubric_url(@graded_rubric)
    end

    assert_redirected_to graded_rubrics_url
  end
end
