require "test_helper"

class StudentSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get student_sessions_new_url
    assert_response :success
  end

  test "should get create" do
    get student_sessions_create_url
    assert_response :success
  end

  test "should get destroy" do
    get student_sessions_destroy_url
    assert_response :success
  end
end
