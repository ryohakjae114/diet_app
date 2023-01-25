require 'test_helper'

class MyRecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @my_recipe = my_recipes(:one)
  end

  test "should get index" do
    get my_recipes_url, as: :json
    assert_response :success
  end

  test "should create my_recipe" do
    assert_difference('MyRecipe.count') do
      post my_recipes_url, params: { my_recipe: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show my_recipe" do
    get my_recipe_url(@my_recipe), as: :json
    assert_response :success
  end

  test "should update my_recipe" do
    patch my_recipe_url(@my_recipe), params: { my_recipe: {  } }, as: :json
    assert_response 200
  end

  test "should destroy my_recipe" do
    assert_difference('MyRecipe.count', -1) do
      delete my_recipe_url(@my_recipe), as: :json
    end

    assert_response 204
  end
end
