require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, params: { user: { name: "", email: "user@invalid", password: "foo", password_confirmation: "bar" } }
    end
    assert_response :unprocessable_entity
    assert_template "users/new"
    assert_select "div#error_explanation"
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference "User.count", 1 do
      post users_path, params: { user: { name: "Rails Tutorial", email: "user@valid.com", password: "hogehoge", password_confirmation: "hogehoge" } }
    end
    follow_redirect!
    assert_template "users/show"
    assert_not flash[:success] == ""
  end
end
