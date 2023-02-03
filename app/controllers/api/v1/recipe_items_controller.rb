class Api::V1::RecipeItemsController < ApplicationController
  before_action :authenticate_api_v1_user!

  before_action ->{
    set_recipe
  }, only: %i[ index create ]

  before_action ->{
    set_recipe_item
    set_recipe_from_recipe_item
  }, only: %i[ show destroy ]
  
  before_action -> {
    share_data(@recipe)
  }

  # GET /api/v1/recipes/1/recipe_items.json
  def index
    @recipe_items = @recipe.recipe_items
    render json: { status: 'SUCCESS', message: 'Loaded recipe_item', data: @recipe_items }
  end

  # GET /api/v1/recipe_items/1.json
  def show
    render json: { status: 'SUCCESS', message: 'Loaded recipe_item', data: @recipe_item }
  end

  private

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_recipe_item
      @recipe_item = RecipeItem.find(params[:id])
    end

    def set_recipe_from_recipe_item
      @recipe = @recipe_item.recipe
    end
end
