require 'test_helper'

class RecipeItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get recipe_items_edit_url
    assert_response :success
  end

end
