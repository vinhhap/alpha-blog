require "test_helper"

class SignUpNewUserTest < ActionDispatch::IntegrationTest
  
  test "get sign up form and create new user" do
    get signup_path
    assert_template "users/new"
    assert_difference "User.count", 1 do
      post_via_redirect users_path, user: { username: "quandeptrai",
                                          email: "quandeptrai@example.com",
                                          password: "1convitcon",
                                          admin: false }
    end
    assert_template "users/show"
    assert_select "h1.username"
  end
  
  test "invalid sign up" do
    get signup_path
    assert_template "users/new"
    assert_no_difference "User.count" do
      post_via_redirect users_path, user: { username: " ",
                                          email: "quandeptrai@example.com",
                                          password: "1convitcon",
                                          admin: false }
    end
    assert_template "users/new"
    assert_select "div.panel"
  end
  
end