class Api::V1::MyRecipeItemsController < ApplicationController
  protect_from_forgery

  before_action :authenticate_api_v1_user!
  before_action :set_my_recipe,      only: %i[ index create ]
  before_action :set_my_recipe_item, only: %i[ destroy ]
  before_action ->{
    check_data_owner(@my_recipe)
  }

  # GET /api/v1/recipes/1/my_recipe_items.json
  def index
    @my_recipe_items = @my_recipe.recipe_items
    render json: { status: 'SUCCESS', message: 'Loaded my_recipe_item', data: @my_recipe_items }
  end

  # GET /my_recipe_items/1.json
  # def show
  # end

  # POST /api/v1/recipes/1/my_recipe_items.json
  def create
    @my_recipe_item = @my_recipe.recipe_items.build(my_recipe_params)
    item = @my_recipe_item.item

    if @my_recipe_item.weight.nil?
      @my_recipe_item.weight = (@my_recipe_item.kcal / item.kcal) * item.weight
    else
      @my_recipe_item.kcal   = (@my_recipe_item.weight / item.weight) * item.kcal
    end

    if @my_recipe_item.save
      render json: { status: 'SUCCESS', message: 'Loaded my_recipe_item', data: @my_recipe_item }
    else
      render json: { status: 'ERROR', data: @my_recipe_item.errors }
    end
  end

  # PATCH/PUT /my_recipe_items/1.json
  # def update
  #   if @my_recipe_item.update(my_recipe_item_params)
  #     render :show, status: :ok, location: @my_recipe_item
  #   else
  #     render json: @my_recipe_item.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /api/v1/my_recipe_items/1.json
  def destroy
    @my_recipe_item.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the my_recipe_item', data: @my_recipe_item }
  end

  private

    def set_my_recipe
      @my_recipe = Recipe.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_my_recipe_item
      @my_recipe_item = RecipeItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def my_recipe_item_params
      params.fetch(:my_recipe_item, {}).permit(:item_id, :kcal, :weight)
    end
end
