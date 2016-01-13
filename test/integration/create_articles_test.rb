require "test_helper"

class CreateArticlesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(username: "quandeptrai", email: "quandeptrai@example.com", password: "quandeptrai")
  end
  
  test "get new article form and create article" do
    sign_in_as(@user, "quandeptrai")
    get new_article_path
    assert_template "articles/new"
    assert_difference "Article.count", 1 do
      post_via_redirect articles_path, article: { title: "this is test titleasdasd",
                                                  description: "This is the body of the test articleasdas" }
    end
    assert_template "articles/show"
    assert_select "h2.text-center"
  end
  
  test "invalid article" do
    sign_in_as(@user, "quandeptrai")
    get new_article_path
    assert_template "articles/new"
    assert_no_difference "Article.count" do
      post_via_redirect articles_path, article: { title: " ",
                                                  description: "This is the body of the test article" }
    end
    assert_template "articles/new"
    assert_select "div.panel.panel-danger"
  end
end