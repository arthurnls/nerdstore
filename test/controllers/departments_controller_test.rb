require 'test_helper'

class DepartmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get departments_show_url
    assert_response :success
  end

end
