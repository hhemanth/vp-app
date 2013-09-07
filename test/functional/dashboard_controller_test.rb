require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  test "should get by_dept" do
    get :by_dept
    assert_response :success
  end

end
