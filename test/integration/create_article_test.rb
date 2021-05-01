require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest

  setup do
    @user = User.create(username: "Yoru", email: "yoru@gmail.com", password: "password123", admin: false)
  end

  test "get new article form and create article" do
    sign_in_as(@user)
    get '/articles/new'
    assert_response :success
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: "test title", description: "test description"} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "test title", response.body
  end

end