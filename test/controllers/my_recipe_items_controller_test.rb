require 'test_helper'

class MyRecipeItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @my_recipe_item = my_recipe_items(:one)
  end

  test "should get index" do
    get my_recipe_items_url, as: :json
    assert_response :success
  end

  test "should create my_recipe_item" do
    assert_difference('MyRecipeItem.count') do
      post my_recipe_items_url, params: { my_recipe_item: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show my_recipe_item" do
    get my_recipe_item_url(@my_recipe_item), as: :json
    assert_response :success
  end

  test "should update my_recipe_item" do
    patch my_recipe_item_url(@my_recipe_item), params: { my_recipe_item: {  } }, as: :json
    assert_response 200
  end

  test "should destroy my_recipe_item" do
    assert_difference('MyRecipeItem.count', -1) do
      delete my_recipe_item_url(@my_recipe_item), as: :json
    end

    assert_response 204
  end
end
