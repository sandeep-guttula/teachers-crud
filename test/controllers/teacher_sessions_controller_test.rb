require "test_helper"

class TeacherSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get teacher_sessions_new_url
    assert_response :success
  end

  test "should get create" do
    get teacher_sessions_create_url
    assert_response :success
  end

  test "should get destroy" do
    get teacher_sessions_destroy_url
    assert_response :success
  end
end
