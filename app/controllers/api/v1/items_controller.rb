class Api::V1::ItemsController < ApplicationController
  before_action :authenticate_api_v1_user!
  
  before_action ->{
    set_items
  }, only: %i[search index]
  
  before_action ->{
    set_item
    share_data(@item)
  }, only: :show

  # GET /api/v1/items/search/a
  # GET /api/v1/items/search/a.json
  def search
    @hit_items = @items.where("name LIKE ? ", '%'+params[:keyword]+'%')
    render json: { status: 'SUCCESS', message: 'Loaded items', data: @hit_items }
  end

  # GET /api/v1/items
  # GET /api/v1/items.json
  def index
    render json: { status: 'SUCCESS', message: 'Loaded items', data: @items }
  end

  # GET /api/v1/items/1
  # GET /api/v1/items/1.json
  def show
    render json: { status: 'SUCCESS', message: 'Loaded the my_item', data: @item }
  end


  private

    def set_items
      @items = Item.where(user_id: nil)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end
end
