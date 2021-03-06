require "test_helper"

class UserSignUpTest < ActionDispatch::IntegrationTest

  test "get sign up form and create user account" do
    get '/signup'
    assert_response :success
    assert_difference 'User.count', 1 do
        post users_path, params: { user: { username: "Yoruchan", email: "yoruchan@gmail.com", password: "password123"} }
        assert_response :redirect
    end
        follow_redirect!
        assert_response :success
        assert_match "Yoruchan", response.body
  end

  test "get new user and reject invalid username" do
    get "/signup"
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "bo", email: "bob@hope.com", password: "password"} }
    end
    assert_match "Username is too short", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
 
  test "get new user and reject blank password" do
    get "/signup"
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "bobhope", email: "bob@hope.com", password: ""} }
    end
    assert_match "blank", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
 
  test "get new user and reject existing email address" do
    User.create(username: "roberthope", email: "bob@hope.com", password: "password")
    get "/signup"
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "bobhope", email: "bob@hope.com", password: "password"} }
    end
    assert_match "been taken", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

end