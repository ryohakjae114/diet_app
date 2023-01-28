require 'test_helper'

class MealMenusControllerTest < ActionDispatch::IntegrationTest
  setup do
    @meal_menu = meal_menus(:one)
  end

  test "should get index" do
    get meal_menus_url, as: :json
    assert_response :success
  end

  test "should create meal_menu" do
    assert_difference('MealMenu.count') do
      post meal_menus_url, params: { meal_menu: { count: @meal_menu.count, recipe_id_id: @meal_menu.recipe_id_id } }, as: :json
    end

    assert_response 201
  end

  test "should show meal_menu" do
    get meal_menu_url(@meal_menu), as: :json
    assert_response :success
  end

  test "should update meal_menu" do
    patch meal_menu_url(@meal_menu), params: { meal_menu: { count: @meal_menu.count, recipe_id_id: @meal_menu.recipe_id_id } }, as: :json
    assert_response 200
  end

  test "should destroy meal_menu" do
    assert_difference('MealMenu.count', -1) do
      delete meal_menu_url(@meal_menu), as: :json
    end

    assert_response 204
  end
end
