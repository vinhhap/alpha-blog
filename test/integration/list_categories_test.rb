require "test_helper"

class ListCategoriesHelper < ActionDispatch::IntegrationTest
  
  def setup
    @category = Category.create(name: "football")
    @category2 = Category.create(name: "XXX")
  end
  
  test "should show categories listing" do
    get categories_path
    assert_template "categories/index"
    assert_select "a[href=?]", category_path(@category), text:@category.name
    assert_select "a[href=?]", category_path(@category2), text:@category2.name
  end
end