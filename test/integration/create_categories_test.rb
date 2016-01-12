require "test_helper"

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "admin", email: "admin@gmail.com", password: "admin", admin: true)
  end
  test "get new category form and create category" do
    sign_in_as(@user, "admin")
    get new_category_path
    assert_template "categories/new"
    assert_difference "Category.count", 1 do
      post_via_redirect categories_path, category: { name: "football" }
    end
    assert_template "categories/index"
    assert_match "football", response.body
  end
  
  test "invalid category submission results in failure" do
    sign_in_as(@user, "admin")
    get new_category_path
    assert_template "categories/new"
    assert_no_difference "Category.count" do
      post_via_redirect categories_path, category: { name: " " }
    end
    assert_template "categories/new"
    assert_select "div.panel.panel-danger"
  end
end