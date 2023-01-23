class Api::V1::MyItemsController < ApplicationController
  before_action :set_my_item, only: %i[ show update destroy ]

  # GET /my_items
  # GET /my_items.json
  def index
    logger.debug(current_api_v1_user.email)
    @my_items = current_api_v1_user.items
  end

  # GET /my_items/1
  # GET /my_items/1.json
  def show
  end

  # POST /my_items
  # POST /my_items.json
  def create
    @my_item = current_api_v1_user.items.build(my_item_params)

    if @my_item.save
      render :show, status: :created, location: @my_item
    else
      render json: @my_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /my_items/1
  # PATCH/PUT /my_items/1.json
  def update
    if @my_item.update(my_item_params)
      render :show, status: :ok, location: @my_item
    else
      render json: @my_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /my_items/1
  # DELETE /my_items/1.json
  def destroy
    @my_item.destroy
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
