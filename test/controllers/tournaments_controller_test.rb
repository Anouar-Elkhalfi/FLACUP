require "test_helper"

class TournamentsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get tournaments_show_url
    assert_response :success
  end
end
