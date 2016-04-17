require 'test_helper'

class LocationControllerTest < ActionController::TestCase
  test "should get location" do
    get :location
    assert_response :success
  end

end
