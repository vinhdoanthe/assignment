require "application_system_test_case"

class CriteriaFormatsTest < ApplicationSystemTestCase
  setup do
    @criteria_format = criteria_formats(:one)
  end

  test "visiting the index" do
    visit criteria_formats_url
    assert_selector "h1", text: "Criteria Formats"
  end

  test "creating a Criteria format" do
    visit criteria_formats_url
    click_on "New Criteria Format"

    fill_in "Description", with: @criteria_format.description
    fill_in "Point", with: @criteria_format.point
    check "Required" if @criteria_format.required
    fill_in "Rubric", with: @criteria_format.rubric_id
    click_on "Create Criteria format"

    assert_text "Criteria format was successfully created"
    click_on "Back"
  end

  test "updating a Criteria format" do
    visit criteria_formats_url
    click_on "Edit", match: :first

    fill_in "Description", with: @criteria_format.description
    fill_in "Point", with: @criteria_format.point
    check "Required" if @criteria_format.required
    fill_in "Rubric", with: @criteria_format.rubric_id
    click_on "Update Criteria format"

    assert_text "Criteria format was successfully updated"
    click_on "Back"
  end

  test "destroying a Criteria format" do
    visit criteria_formats_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Criteria format was successfully destroyed"
  end
end
