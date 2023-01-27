require 'test_helper'

class MySetRecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @my_set_recipe = my_set_recipes(:one)
  end

  test "should get index" do
    get my_set_recipes_url, as: :json
    assert_response :success
  end

  test "should create my_set_recipe" do
    assert_difference('MySetRecipe.count') do
      post my_set_recipes_url, params: { my_set_recipe: { count: @my_set_recipe.count, recipe_id: @my_set_recipe.recipe_id } }, as: :json
    end

    assert_response 201
  end

  test "should show my_set_recipe" do
    get my_set_recipe_url(@my_set_recipe), as: :json
    assert_response :success
  end

  test "should update my_set_recipe" do
    patch my_set_recipe_url(@my_set_recipe), params: { my_set_recipe: { count: @my_set_recipe.count, recipe_id: @my_set_recipe.recipe_id } }, as: :json
    assert_response 200
  end

  test "should destroy my_set_recipe" do
    assert_difference('MySetRecipe.count', -1) do
      delete my_set_recipe_url(@my_set_recipe), as: :json
    end

    assert_response 204
  end
end
