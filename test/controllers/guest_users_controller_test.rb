require "test_helper"

class GuestUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get guest_users_new_url
    assert_response :success
  end
end
