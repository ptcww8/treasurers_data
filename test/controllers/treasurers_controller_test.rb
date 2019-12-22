require 'test_helper'

class TreasurersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @treasurer = treasurers(:one)
  end

  test "should get index" do
    get treasurers_url
    assert_response :success
  end

  test "should get new" do
    get new_treasurer_url
    assert_response :success
  end

  test "should create treasurer" do
    assert_difference('Treasurer.count') do
      post treasurers_url, params: { treasurer: { bishop_podcast: @treasurer.bishop_podcast, born_again: @treasurer.born_again, branch_id: @treasurer.branch_id, conference: @treasurer.conference, council: @treasurer.council, date_of_birth: @treasurer.date_of_birth, education_level: @treasurer.education_level, employment_status: @treasurer.employment_status, first_name: @treasurer.first_name, last_name: @treasurer.last_name, middle_name: @treasurer.middle_name, phone_number: @treasurer.phone_number, tithe: @treasurer.tithe, training_manual: @treasurer.training_manual, treasurer_type: @treasurer.treasurer_type, ud_join: @treasurer.ud_join, whatsapp_number: @treasurer.whatsapp_number, year_treasurer: @treasurer.year_treasurer } }
    end

    assert_redirected_to treasurer_url(Treasurer.last)
  end

  test "should show treasurer" do
    get treasurer_url(@treasurer)
    assert_response :success
  end

  test "should get edit" do
    get edit_treasurer_url(@treasurer)
    assert_response :success
  end

  test "should update treasurer" do
    patch treasurer_url(@treasurer), params: { treasurer: { bishop_podcast: @treasurer.bishop_podcast, born_again: @treasurer.born_again, branch_id: @treasurer.branch_id, conference: @treasurer.conference, council: @treasurer.council, date_of_birth: @treasurer.date_of_birth, education_level: @treasurer.education_level, employment_status: @treasurer.employment_status, first_name: @treasurer.first_name, last_name: @treasurer.last_name, middle_name: @treasurer.middle_name, phone_number: @treasurer.phone_number, tithe: @treasurer.tithe, training_manual: @treasurer.training_manual, treasurer_type: @treasurer.treasurer_type, ud_join: @treasurer.ud_join, whatsapp_number: @treasurer.whatsapp_number, year_treasurer: @treasurer.year_treasurer } }
    assert_redirected_to treasurer_url(@treasurer)
  end

  test "should destroy treasurer" do
    assert_difference('Treasurer.count', -1) do
      delete treasurer_url(@treasurer)
    end

    assert_redirected_to treasurers_url
  end
end
