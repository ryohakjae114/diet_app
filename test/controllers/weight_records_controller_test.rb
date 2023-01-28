require 'test_helper'

class WeightRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @weight_record = weight_records(:one)
  end

  test "should get index" do
    get weight_records_url, as: :json
    assert_response :success
  end

  test "should create weight_record" do
    assert_difference('WeightRecord.count') do
      post weight_records_url, params: { weight_record: { user_id: @weight_record.user_id, weight: @weight_record.weight } }, as: :json
    end

    assert_response 201
  end

  test "should show weight_record" do
    get weight_record_url(@weight_record), as: :json
    assert_response :success
  end

  test "should update weight_record" do
    patch weight_record_url(@weight_record), params: { weight_record: { user_id: @weight_record.user_id, weight: @weight_record.weight } }, as: :json
    assert_response 200
  end

  test "should destroy weight_record" do
    assert_difference('WeightRecord.count', -1) do
      delete weight_record_url(@weight_record), as: :json
    end

    assert_response 204
  end
end
