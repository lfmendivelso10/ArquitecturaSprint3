require 'test_helper'

class RecoverControllerTest < ActionController::TestCase
  test "should get record" do
    get :record
    assert_response :success
  end

  test "should get notify" do
    get :notify
    assert_response :success
  end

end
