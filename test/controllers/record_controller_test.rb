require 'test_helper'

class RecordControllerTest < ActionController::TestCase
  test "should get post" do
    get :post
    assert_response :success
  end

  test "should get get" do
    get :get
    assert_response :success
  end

  test "should get loader" do
    get :loader
    assert_response :success
  end

end
