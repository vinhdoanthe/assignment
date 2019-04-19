require "application_system_test_case"

class GradedRubricsTest < ApplicationSystemTestCase
  setup do
    @graded_rubric = graded_rubrics(:one)
  end

  test "visiting the index" do
    visit graded_rubrics_url
    assert_selector "h1", text: "Graded Rubrics"
  end

  test "creating a Graded rubric" do
    visit graded_rubrics_url
    click_on "New Graded Rubric"

    fill_in "Cr10 des", with: @graded_rubric.cr10_des
    check "Cr10 enable" if @graded_rubric.cr10_enable
    fill_in "Cr10 score", with: @graded_rubric.cr10_score
    fill_in "Cr11 des", with: @graded_rubric.cr11_des
    check "Cr11 enable" if @graded_rubric.cr11_enable
    fill_in "Cr11 score", with: @graded_rubric.cr11_score
    fill_in "Cr12 des", with: @graded_rubric.cr12_des
    check "Cr12 enable" if @graded_rubric.cr12_enable
    fill_in "Cr12 score", with: @graded_rubric.cr12_score
    fill_in "Cr13 des", with: @graded_rubric.cr13_des
    check "Cr13 enable" if @graded_rubric.cr13_enable
    fill_in "Cr13 score", with: @graded_rubric.cr13_score
    fill_in "Cr14 des", with: @graded_rubric.cr14_des
    check "Cr14 enable" if @graded_rubric.cr14_enable
    fill_in "Cr14 score", with: @graded_rubric.cr14_score
    fill_in "Cr15 des", with: @graded_rubric.cr15_des
    check "Cr15 enable" if @graded_rubric.cr15_enable
    fill_in "Cr15 score", with: @graded_rubric.cr15_score
    fill_in "Cr16 des", with: @graded_rubric.cr16_des
    check "Cr16 enable" if @graded_rubric.cr16_enable
    fill_in "Cr16 score", with: @graded_rubric.cr16_score
    fill_in "Cr1 des", with: @graded_rubric.cr1_des
    check "Cr1 enable" if @graded_rubric.cr1_enable
    fill_in "Cr1 score", with: @graded_rubric.cr1_score
    fill_in "Cr2 des", with: @graded_rubric.cr2_des
    check "Cr2 enable" if @graded_rubric.cr2_enable
    fill_in "Cr2 score", with: @graded_rubric.cr2_score
    fill_in "Cr3 des", with: @graded_rubric.cr3_des
    check "Cr3 enable" if @graded_rubric.cr3_enable
    fill_in "Cr3 score", with: @graded_rubric.cr3_score
    fill_in "Cr4 des", with: @graded_rubric.cr4_des
    check "Cr4 enable" if @graded_rubric.cr4_enable
    fill_in "Cr4 score", with: @graded_rubric.cr4_score
    fill_in "Cr5 des", with: @graded_rubric.cr5_des
    check "Cr5 enable" if @graded_rubric.cr5_enable
    fill_in "Cr5 score", with: @graded_rubric.cr5_score
    fill_in "Cr6 des", with: @graded_rubric.cr6_des
    check "Cr6 enable" if @graded_rubric.cr6_enable
    fill_in "Cr6 score", with: @graded_rubric.cr6_score
    fill_in "Cr7 des", with: @graded_rubric.cr7_des
    check "Cr7 enable" if @graded_rubric.cr7_enable
    fill_in "Cr7 score", with: @graded_rubric.cr7_score
    fill_in "Cr8 des", with: @graded_rubric.cr8_des
    check "Cr8 enable" if @graded_rubric.cr8_enable
    fill_in "Cr8 score", with: @graded_rubric.cr8_score
    fill_in "Cr9 des", with: @graded_rubric.cr9_des
    check "Cr9 enable" if @graded_rubric.cr9_enable
    fill_in "Cr9 score", with: @graded_rubric.cr9_score
    fill_in "Point", with: @graded_rubric.point
    fill_in "Rubric", with: @graded_rubric.rubric_id
    fill_in "Status", with: @graded_rubric.status
    fill_in "Type", with: @graded_rubric.type
    click_on "Create Graded rubric"

    assert_text "Graded rubric was successfully created"
    click_on "Back"
  end

  test "updating a Graded rubric" do
    visit graded_rubrics_url
    click_on "Edit", match: :first

    fill_in "Cr10 des", with: @graded_rubric.cr10_des
    check "Cr10 enable" if @graded_rubric.cr10_enable
    fill_in "Cr10 score", with: @graded_rubric.cr10_score
    fill_in "Cr11 des", with: @graded_rubric.cr11_des
    check "Cr11 enable" if @graded_rubric.cr11_enable
    fill_in "Cr11 score", with: @graded_rubric.cr11_score
    fill_in "Cr12 des", with: @graded_rubric.cr12_des
    check "Cr12 enable" if @graded_rubric.cr12_enable
    fill_in "Cr12 score", with: @graded_rubric.cr12_score
    fill_in "Cr13 des", with: @graded_rubric.cr13_des
    check "Cr13 enable" if @graded_rubric.cr13_enable
    fill_in "Cr13 score", with: @graded_rubric.cr13_score
    fill_in "Cr14 des", with: @graded_rubric.cr14_des
    check "Cr14 enable" if @graded_rubric.cr14_enable
    fill_in "Cr14 score", with: @graded_rubric.cr14_score
    fill_in "Cr15 des", with: @graded_rubric.cr15_des
    check "Cr15 enable" if @graded_rubric.cr15_enable
    fill_in "Cr15 score", with: @graded_rubric.cr15_score
    fill_in "Cr16 des", with: @graded_rubric.cr16_des
    check "Cr16 enable" if @graded_rubric.cr16_enable
    fill_in "Cr16 score", with: @graded_rubric.cr16_score
    fill_in "Cr1 des", with: @graded_rubric.cr1_des
    check "Cr1 enable" if @graded_rubric.cr1_enable
    fill_in "Cr1 score", with: @graded_rubric.cr1_score
    fill_in "Cr2 des", with: @graded_rubric.cr2_des
    check "Cr2 enable" if @graded_rubric.cr2_enable
    fill_in "Cr2 score", with: @graded_rubric.cr2_score
    fill_in "Cr3 des", with: @graded_rubric.cr3_des
    check "Cr3 enable" if @graded_rubric.cr3_enable
    fill_in "Cr3 score", with: @graded_rubric.cr3_score
    fill_in "Cr4 des", with: @graded_rubric.cr4_des
    check "Cr4 enable" if @graded_rubric.cr4_enable
    fill_in "Cr4 score", with: @graded_rubric.cr4_score
    fill_in "Cr5 des", with: @graded_rubric.cr5_des
    check "Cr5 enable" if @graded_rubric.cr5_enable
    fill_in "Cr5 score", with: @graded_rubric.cr5_score
    fill_in "Cr6 des", with: @graded_rubric.cr6_des
    check "Cr6 enable" if @graded_rubric.cr6_enable
    fill_in "Cr6 score", with: @graded_rubric.cr6_score
    fill_in "Cr7 des", with: @graded_rubric.cr7_des
    check "Cr7 enable" if @graded_rubric.cr7_enable
    fill_in "Cr7 score", with: @graded_rubric.cr7_score
    fill_in "Cr8 des", with: @graded_rubric.cr8_des
    check "Cr8 enable" if @graded_rubric.cr8_enable
    fill_in "Cr8 score", with: @graded_rubric.cr8_score
    fill_in "Cr9 des", with: @graded_rubric.cr9_des
    check "Cr9 enable" if @graded_rubric.cr9_enable
    fill_in "Cr9 score", with: @graded_rubric.cr9_score
    fill_in "Point", with: @graded_rubric.point
    fill_in "Rubric", with: @graded_rubric.rubric_id
    fill_in "Status", with: @graded_rubric.status
    fill_in "Type", with: @graded_rubric.type
    click_on "Update Graded rubric"

    assert_text "Graded rubric was successfully updated"
    click_on "Back"
  end

  test "destroying a Graded rubric" do
    visit graded_rubrics_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Graded rubric was successfully destroyed"
  end
end
