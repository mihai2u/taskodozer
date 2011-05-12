require 'test_helper'

class AdministrationControllerTest < ActionController::TestCase
  test "should get management" do
    get :management
    assert_response :success
  end

end
