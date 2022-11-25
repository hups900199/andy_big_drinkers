require "test_helper"

class ContextsControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get contexts_home_url
    assert_response :success
  end

  test "should get about" do
    get contexts_about_url
    assert_response :success
  end
end
