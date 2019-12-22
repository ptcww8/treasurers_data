require "application_system_test_case"

class TreasurersTest < ApplicationSystemTestCase
  setup do
    @treasurer = treasurers(:one)
  end

  test "visiting the index" do
    visit treasurers_url
    assert_selector "h1", text: "Treasurers"
  end

  test "creating a Treasurer" do
    visit treasurers_url
    click_on "New Treasurer"

    check "Bishop podcast" if @treasurer.bishop_podcast
    check "Born again" if @treasurer.born_again
    fill_in "Branch", with: @treasurer.branch_id
    fill_in "Conference", with: @treasurer.conference
    fill_in "Council", with: @treasurer.council
    fill_in "Date of birth", with: @treasurer.date_of_birth
    fill_in "Education level", with: @treasurer.education_level
    fill_in "Employment status", with: @treasurer.employment_status
    fill_in "First name", with: @treasurer.first_name
    fill_in "Last name", with: @treasurer.last_name
    fill_in "Middle name", with: @treasurer.middle_name
    fill_in "Phone number", with: @treasurer.phone_number
    fill_in "Tithe", with: @treasurer.tithe
    check "Training manual" if @treasurer.training_manual
    fill_in "Treasurer type", with: @treasurer.treasurer_type
    fill_in "Ud join", with: @treasurer.ud_join
    fill_in "Whatsapp number", with: @treasurer.whatsapp_number
    fill_in "Year treasurer", with: @treasurer.year_treasurer
    click_on "Create Treasurer"

    assert_text "Treasurer was successfully created"
    click_on "Back"
  end

  test "updating a Treasurer" do
    visit treasurers_url
    click_on "Edit", match: :first

    check "Bishop podcast" if @treasurer.bishop_podcast
    check "Born again" if @treasurer.born_again
    fill_in "Branch", with: @treasurer.branch_id
    fill_in "Conference", with: @treasurer.conference
    fill_in "Council", with: @treasurer.council
    fill_in "Date of birth", with: @treasurer.date_of_birth
    fill_in "Education level", with: @treasurer.education_level
    fill_in "Employment status", with: @treasurer.employment_status
    fill_in "First name", with: @treasurer.first_name
    fill_in "Last name", with: @treasurer.last_name
    fill_in "Middle name", with: @treasurer.middle_name
    fill_in "Phone number", with: @treasurer.phone_number
    fill_in "Tithe", with: @treasurer.tithe
    check "Training manual" if @treasurer.training_manual
    fill_in "Treasurer type", with: @treasurer.treasurer_type
    fill_in "Ud join", with: @treasurer.ud_join
    fill_in "Whatsapp number", with: @treasurer.whatsapp_number
    fill_in "Year treasurer", with: @treasurer.year_treasurer
    click_on "Update Treasurer"

    assert_text "Treasurer was successfully updated"
    click_on "Back"
  end

  test "destroying a Treasurer" do
    visit treasurers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Treasurer was successfully destroyed"
  end
end
