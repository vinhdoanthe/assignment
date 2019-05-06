require "application_system_test_case"

class GradedCriteriaTest < ApplicationSystemTestCase
  setup do
    @graded_criterium = graded_criteria(:one)
  end

  test "visiting the index" do
    visit graded_criteria_url
    assert_selector "h1", text: "Graded Criteria"
  end

  test "creating a Graded criterium" do
    visit graded_criteria_url
    click_on "New Graded Criterium"

    fill_in "Comment", with: @graded_criterium.comment
    fill_in "Description", with: @graded_criterium.description
    fill_in "Graded rubric", with: @graded_criterium.graded_rubric_id
    check "Is passed" if @graded_criterium.is_passed
    fill_in "Point", with: @graded_criterium.point
    check "Required" if @graded_criterium.required
    click_on "Create Graded criterium"

    assert_text "Graded criterium was successfully created"
    click_on "Back"
  end

  test "updating a Graded criterium" do
    visit graded_criteria_url
    click_on "Edit", match: :first

    fill_in "Comment", with: @graded_criterium.comment
    fill_in "Description", with: @graded_criterium.description
    fill_in "Graded rubric", with: @graded_criterium.graded_rubric_id
    check "Is passed" if @graded_criterium.is_passed
    fill_in "Point", with: @graded_criterium.point
    check "Required" if @graded_criterium.required
    click_on "Update Graded criterium"

    assert_text "Graded criterium was successfully updated"
    click_on "Back"
  end

  test "destroying a Graded criterium" do
    visit graded_criteria_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Graded criterium was successfully destroyed"
  end
end
