require "test_helper"

class ProfilsControllerTest < ActionDispatch::IntegrationTest
  test "should get theme" do
    get profils_theme_url
    assert_response :success
  end
end
