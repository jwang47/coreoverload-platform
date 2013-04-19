require 'test_helper'

class GameSessionControllerTest < ActionController::TestCase
  test "should get process" do
    get :process
    assert_response :success
  end

end
