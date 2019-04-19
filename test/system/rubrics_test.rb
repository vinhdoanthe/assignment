require "application_system_test_case"

class RubricsTest < ApplicationSystemTestCase
  setup do
    @rubric = rubrics(:one)
  end

  test "visiting the index" do
    visit rubrics_url
    assert_selector "h1", text: "Rubrics"
  end

  test "creating a Rubric" do
    visit rubrics_url
    click_on "New Rubric"

    fill_in "Assignment", with: @rubric.assignment_id
    fill_in "Cr10 des", with: @rubric.cr10_des
    check "Cr10 enable" if @rubric.cr10_enable
    fill_in "Cr10 score", with: @rubric.cr10_score
    fill_in "Cr11 des", with: @rubric.cr11_des
    check "Cr11 enable" if @rubric.cr11_enable
    fill_in "Cr11 score", with: @rubric.cr11_score
    fill_in "Cr12 des", with: @rubric.cr12_des
    check "Cr12 enable" if @rubric.cr12_enable
    fill_in "Cr12 score", with: @rubric.cr12_score
    fill_in "Cr13 des", with: @rubric.cr13_des
    check "Cr13 enable" if @rubric.cr13_enable
    fill_in "Cr13 score", with: @rubric.cr13_score
    fill_in "Cr14 des", with: @rubric.cr14_des
    check "Cr14 enable" if @rubric.cr14_enable
    fill_in "Cr14 score", with: @rubric.cr14_score
    fill_in "Cr15 des", with: @rubric.cr15_des
    check "Cr15 enable" if @rubric.cr15_enable
    fill_in "Cr15 score", with: @rubric.cr15_score
    fill_in "Cr16 des", with: @rubric.cr16_des
    check "Cr16 enable" if @rubric.cr16_enable
    fill_in "Cr16 score", with: @rubric.cr16_score
    fill_in "Cr1 des", with: @rubric.cr1_des
    check "Cr1 enable" if @rubric.cr1_enable
    fill_in "Cr1 score", with: @rubric.cr1_score
    fill_in "Cr2 des", with: @rubric.cr2_des
    check "Cr2 enable" if @rubric.cr2_enable
    fill_in "Cr2 score", with: @rubric.cr2_score
    fill_in "Cr3 des", with: @rubric.cr3_des
    check "Cr3 enable" if @rubric.cr3_enable
    fill_in "Cr3 score", with: @rubric.cr3_score
    fill_in "Cr4 des", with: @rubric.cr4_des
    check "Cr4 enable" if @rubric.cr4_enable
    fill_in "Cr4 score", with: @rubric.cr4_score
    fill_in "Cr5 des", with: @rubric.cr5_des
    check "Cr5 enable" if @rubric.cr5_enable
    fill_in "Cr5 score", with: @rubric.cr5_score
    fill_in "Cr6 des", with: @rubric.cr6_des
    check "Cr6 enable" if @rubric.cr6_enable
    fill_in "Cr6 score", with: @rubric.cr6_score
    fill_in "Cr7 des", with: @rubric.cr7_des
    check "Cr7 enable" if @rubric.cr7_enable
    fill_in "Cr7 score", with: @rubric.cr7_score
    fill_in "Cr8 des", with: @rubric.cr8_des
    check "Cr8 enable" if @rubric.cr8_enable
    fill_in "Cr8 score", with: @rubric.cr8_score
    fill_in "Cr9 des", with: @rubric.cr9_des
    check "Cr9 enable" if @rubric.cr9_enable
    fill_in "Cr9 score", with: @rubric.cr9_score
    fill_in "Status", with: @rubric.status
    fill_in "Type", with: @rubric.type
    click_on "Create Rubric"

    assert_text "Rubric was successfully created"
    click_on "Back"
  end

  test "updating a Rubric" do
    visit rubrics_url
    click_on "Edit", match: :first

    fill_in "Assignment", with: @rubric.assignment_id
    fill_in "Cr10 des", with: @rubric.cr10_des
    check "Cr10 enable" if @rubric.cr10_enable
    fill_in "Cr10 score", with: @rubric.cr10_score
    fill_in "Cr11 des", with: @rubric.cr11_des
    check "Cr11 enable" if @rubric.cr11_enable
    fill_in "Cr11 score", with: @rubric.cr11_score
    fill_in "Cr12 des", with: @rubric.cr12_des
    check "Cr12 enable" if @rubric.cr12_enable
    fill_in "Cr12 score", with: @rubric.cr12_score
    fill_in "Cr13 des", with: @rubric.cr13_des
    check "Cr13 enable" if @rubric.cr13_enable
    fill_in "Cr13 score", with: @rubric.cr13_score
    fill_in "Cr14 des", with: @rubric.cr14_des
    check "Cr14 enable" if @rubric.cr14_enable
    fill_in "Cr14 score", with: @rubric.cr14_score
    fill_in "Cr15 des", with: @rubric.cr15_des
    check "Cr15 enable" if @rubric.cr15_enable
    fill_in "Cr15 score", with: @rubric.cr15_score
    fill_in "Cr16 des", with: @rubric.cr16_des
    check "Cr16 enable" if @rubric.cr16_enable
    fill_in "Cr16 score", with: @rubric.cr16_score
    fill_in "Cr1 des", with: @rubric.cr1_des
    check "Cr1 enable" if @rubric.cr1_enable
    fill_in "Cr1 score", with: @rubric.cr1_score
    fill_in "Cr2 des", with: @rubric.cr2_des
    check "Cr2 enable" if @rubric.cr2_enable
    fill_in "Cr2 score", with: @rubric.cr2_score
    fill_in "Cr3 des", with: @rubric.cr3_des
    check "Cr3 enable" if @rubric.cr3_enable
    fill_in "Cr3 score", with: @rubric.cr3_score
    fill_in "Cr4 des", with: @rubric.cr4_des
    check "Cr4 enable" if @rubric.cr4_enable
    fill_in "Cr4 score", with: @rubric.cr4_score
    fill_in "Cr5 des", with: @rubric.cr5_des
    check "Cr5 enable" if @rubric.cr5_enable
    fill_in "Cr5 score", with: @rubric.cr5_score
    fill_in "Cr6 des", with: @rubric.cr6_des
    check "Cr6 enable" if @rubric.cr6_enable
    fill_in "Cr6 score", with: @rubric.cr6_score
    fill_in "Cr7 des", with: @rubric.cr7_des
    check "Cr7 enable" if @rubric.cr7_enable
    fill_in "Cr7 score", with: @rubric.cr7_score
    fill_in "Cr8 des", with: @rubric.cr8_des
    check "Cr8 enable" if @rubric.cr8_enable
    fill_in "Cr8 score", with: @rubric.cr8_score
    fill_in "Cr9 des", with: @rubric.cr9_des
    check "Cr9 enable" if @rubric.cr9_enable
    fill_in "Cr9 score", with: @rubric.cr9_score
    fill_in "Status", with: @rubric.status
    fill_in "Type", with: @rubric.type
    click_on "Update Rubric"

    assert_text "Rubric was successfully updated"
    click_on "Back"
  end

  test "destroying a Rubric" do
    visit rubrics_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Rubric was successfully destroyed"
  end
end
