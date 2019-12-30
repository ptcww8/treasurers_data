require 'test_helper'

class PerformancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @performance = performances(:one)
  end

  test "should get index" do
    get performances_url
    assert_response :success
  end

  test "should get new" do
    get new_performance_url
    assert_response :success
  end

  test "should create performance" do
    assert_difference('Performance.count') do
      post performances_url, params: { performance: { when_counted: @performance.when_counted, when_paid: @performance.when_paid, who_came: @performance.who_came, who_counted: @performance.who_counted, who_paid: @performance.who_paid } }
    end

    assert_redirected_to performance_url(Performance.last)
  end

  test "should show performance" do
    get performance_url(@performance)
    assert_response :success
  end

  test "should get edit" do
    get edit_performance_url(@performance)
    assert_response :success
  end

  test "should update performance" do
    patch performance_url(@performance), params: { performance: { when_counted: @performance.when_counted, when_paid: @performance.when_paid, who_came: @performance.who_came, who_counted: @performance.who_counted, who_paid: @performance.who_paid } }
    assert_redirected_to performance_url(@performance)
  end

  test "should destroy performance" do
    assert_difference('Performance.count', -1) do
      delete performance_url(@performance)
    end

    assert_redirected_to performances_url
  end
end
