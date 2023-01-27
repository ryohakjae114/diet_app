require 'test_helper'

class MySetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @my_set = my_sets(:one)
  end

  test "should get index" do
    get my_sets_url, as: :json
    assert_response :success
  end

  test "should create my_set" do
    assert_difference('MySet.count') do
      post my_sets_url, params: { my_set: { name: @my_set.name, user_id: @my_set.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show my_set" do
    get my_set_url(@my_set), as: :json
    assert_response :success
  end

  test "should update my_set" do
    patch my_set_url(@my_set), params: { my_set: { name: @my_set.name, user_id: @my_set.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy my_set" do
    assert_difference('MySet.count', -1) do
      delete my_set_url(@my_set), as: :json
    end

    assert_response 204
  end
end
