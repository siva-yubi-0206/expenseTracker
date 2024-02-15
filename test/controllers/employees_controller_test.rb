require "test_helper"

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "index action" do
    get employees_url
    assert_response :success
  end
  
end
