require 'test_helper'

class TodayHabitsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get today_habits_index_url
    assert_response :success
  end

end
