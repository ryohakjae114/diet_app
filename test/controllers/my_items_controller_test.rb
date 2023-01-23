require 'test_helper'

class MyItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @my_item = my_items(:one)
  end

  test "should get index" do
    get my_items_url, as: :json
    assert_response :success
  end

  test "should create my_item" do
    assert_difference('MyItem.count') do
      post my_items_url, params: { my_item: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show my_item" do
    get my_item_url(@my_item), as: :json
    assert_response :success
  end

  test "should update my_item" do
    patch my_item_url(@my_item), params: { my_item: {  } }, as: :json
    assert_response 200
  end

  test "should destroy my_item" do
    assert_difference('MyItem.count', -1) do
      delete my_item_url(@my_item), as: :json
    end

    assert_response 204
  end
end
