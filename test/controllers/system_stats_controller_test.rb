require "test_helper"

class SystemStatsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get system_stats_index_url
    assert_response :success
  end
end
