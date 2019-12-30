require "application_system_test_case"

class PerformancesTest < ApplicationSystemTestCase
  setup do
    @performance = performances(:one)
  end

  test "visiting the index" do
    visit performances_url
    assert_selector "h1", text: "Performances"
  end

  test "creating a Performance" do
    visit performances_url
    click_on "New Performance"

    fill_in "When counted", with: @performance.when_counted
    fill_in "When paid", with: @performance.when_paid
    fill_in "Who came", with: @performance.who_came
    fill_in "Who counted", with: @performance.who_counted
    fill_in "Who paid", with: @performance.who_paid
    click_on "Create Performance"

    assert_text "Performance was successfully created"
    click_on "Back"
  end

  test "updating a Performance" do
    visit performances_url
    click_on "Edit", match: :first

    fill_in "When counted", with: @performance.when_counted
    fill_in "When paid", with: @performance.when_paid
    fill_in "Who came", with: @performance.who_came
    fill_in "Who counted", with: @performance.who_counted
    fill_in "Who paid", with: @performance.who_paid
    click_on "Update Performance"

    assert_text "Performance was successfully updated"
    click_on "Back"
  end

  test "destroying a Performance" do
    visit performances_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Performance was successfully destroyed"
  end
end
