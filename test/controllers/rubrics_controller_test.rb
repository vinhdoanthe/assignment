require 'test_helper'

class RubricsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rubric = rubrics(:one)
  end

  test "should get index" do
    get rubrics_url
    assert_response :success
  end

  test "should get new" do
    get new_rubric_url
    assert_response :success
  end

  test "should create rubric" do
    assert_difference('Rubric.count') do
      post rubrics_url, params: { rubric: { assignment_id: @rubric.assignment_id, cr10_des: @rubric.cr10_des, cr10_enable: @rubric.cr10_enable, cr10_score: @rubric.cr10_score, cr11_des: @rubric.cr11_des, cr11_enable: @rubric.cr11_enable, cr11_score: @rubric.cr11_score, cr12_des: @rubric.cr12_des, cr12_enable: @rubric.cr12_enable, cr12_score: @rubric.cr12_score, cr13_des: @rubric.cr13_des, cr13_enable: @rubric.cr13_enable, cr13_score: @rubric.cr13_score, cr14_des: @rubric.cr14_des, cr14_enable: @rubric.cr14_enable, cr14_score: @rubric.cr14_score, cr15_des: @rubric.cr15_des, cr15_enable: @rubric.cr15_enable, cr15_score: @rubric.cr15_score, cr16_des: @rubric.cr16_des, cr16_enable: @rubric.cr16_enable, cr16_score: @rubric.cr16_score, cr1_des: @rubric.cr1_des, cr1_enable: @rubric.cr1_enable, cr1_score: @rubric.cr1_score, cr2_des: @rubric.cr2_des, cr2_enable: @rubric.cr2_enable, cr2_score: @rubric.cr2_score, cr3_des: @rubric.cr3_des, cr3_enable: @rubric.cr3_enable, cr3_score: @rubric.cr3_score, cr4_des: @rubric.cr4_des, cr4_enable: @rubric.cr4_enable, cr4_score: @rubric.cr4_score, cr5_des: @rubric.cr5_des, cr5_enable: @rubric.cr5_enable, cr5_score: @rubric.cr5_score, cr6_des: @rubric.cr6_des, cr6_enable: @rubric.cr6_enable, cr6_score: @rubric.cr6_score, cr7_des: @rubric.cr7_des, cr7_enable: @rubric.cr7_enable, cr7_score: @rubric.cr7_score, cr8_des: @rubric.cr8_des, cr8_enable: @rubric.cr8_enable, cr8_score: @rubric.cr8_score, cr9_des: @rubric.cr9_des, cr9_enable: @rubric.cr9_enable, cr9_score: @rubric.cr9_score, status: @rubric.status, type: @rubric.type } }
    end

    assert_redirected_to rubric_url(Rubric.last)
  end

  test "should show rubric" do
    get rubric_url(@rubric)
    assert_response :success
  end

  test "should get edit" do
    get edit_rubric_url(@rubric)
    assert_response :success
  end

  test "should update rubric" do
    patch rubric_url(@rubric), params: { rubric: { assignment_id: @rubric.assignment_id, cr10_des: @rubric.cr10_des, cr10_enable: @rubric.cr10_enable, cr10_score: @rubric.cr10_score, cr11_des: @rubric.cr11_des, cr11_enable: @rubric.cr11_enable, cr11_score: @rubric.cr11_score, cr12_des: @rubric.cr12_des, cr12_enable: @rubric.cr12_enable, cr12_score: @rubric.cr12_score, cr13_des: @rubric.cr13_des, cr13_enable: @rubric.cr13_enable, cr13_score: @rubric.cr13_score, cr14_des: @rubric.cr14_des, cr14_enable: @rubric.cr14_enable, cr14_score: @rubric.cr14_score, cr15_des: @rubric.cr15_des, cr15_enable: @rubric.cr15_enable, cr15_score: @rubric.cr15_score, cr16_des: @rubric.cr16_des, cr16_enable: @rubric.cr16_enable, cr16_score: @rubric.cr16_score, cr1_des: @rubric.cr1_des, cr1_enable: @rubric.cr1_enable, cr1_score: @rubric.cr1_score, cr2_des: @rubric.cr2_des, cr2_enable: @rubric.cr2_enable, cr2_score: @rubric.cr2_score, cr3_des: @rubric.cr3_des, cr3_enable: @rubric.cr3_enable, cr3_score: @rubric.cr3_score, cr4_des: @rubric.cr4_des, cr4_enable: @rubric.cr4_enable, cr4_score: @rubric.cr4_score, cr5_des: @rubric.cr5_des, cr5_enable: @rubric.cr5_enable, cr5_score: @rubric.cr5_score, cr6_des: @rubric.cr6_des, cr6_enable: @rubric.cr6_enable, cr6_score: @rubric.cr6_score, cr7_des: @rubric.cr7_des, cr7_enable: @rubric.cr7_enable, cr7_score: @rubric.cr7_score, cr8_des: @rubric.cr8_des, cr8_enable: @rubric.cr8_enable, cr8_score: @rubric.cr8_score, cr9_des: @rubric.cr9_des, cr9_enable: @rubric.cr9_enable, cr9_score: @rubric.cr9_score, status: @rubric.status, type: @rubric.type } }
    assert_redirected_to rubric_url(@rubric)
  end

  test "should destroy rubric" do
    assert_difference('Rubric.count', -1) do
      delete rubric_url(@rubric)
    end

    assert_redirected_to rubrics_url
  end
end
