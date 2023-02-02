class Api::V1::ItemsController < ApplicationController
  
  before_action ->{
    set_item
    share_data(@item)
  }, only: :show

  # GET /api/v1/items
  # GET /api/v1/items.json
  def index
    @items = Item.where(user_id: nil)
    render json: { status: 'SUCCESS', message: 'Loaded items', data: @items }
  end

  # GET /api/v1/items/1
  # GET /api/v1/items/1.json
  def show
    render json: { status: 'SUCCESS', message: 'Loaded the my_item', data: @item }
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end
end
