class Api::V1::MyItemsController < ApplicationController
  protect_from_forgery

  before_action :authenticate_api_v1_user!
  before_action ->{
    set_my_item
    check_data_owner(@my_item)
  }, only: %i[ show update destroy ]

  # GET /api/v1/my_items.json
  def index
    @my_items = current_api_v1_user.items
    render json: { status: 'SUCCESS', message: 'Loaded my_items', data: @my_items }
  end

  # GET /api/v1/my_items/1.json
  def show
    render json: { status: 'SUCCESS', message: 'Loaded the my_item', data: @my_item }
  end

  # POST /api/v1/my_items.json
  def create
    @my_item = current_api_v1_user.items.build(my_item_params)

    if @my_item.save
      render json: { status: 'SUCCESS', data: @my_item }
    else
      render json: { status: 'ERROR', data: @my_item.errors }
    end
  end

  # PATCH/PUT /api/v1/my_items/1.json
  def update
    if @my_item.update(my_item_params)
      render json: { status: 'SUCCESS', message: 'Updated the my_item', data: @my_item }
    else
      render json: { status: 'ERROR', message: 'Not updated', data: @my_item.errors }
    end
  end

  # DELETE /api/v1/my_items/1.json
  def destroy
    @my_item.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the my_item', data: @my_item }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_my_item
      @my_item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def my_item_params
      params.fetch(:my_item, {}).permit(:name, :kcal, :protein, :fat, :carb, :df,
                                        :around_qty, :unit, :weight)
    end
end
