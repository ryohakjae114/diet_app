class Api::V1::RecipeItemsController < ApplicationController
  protect_from_forgery

  before_action :authenticate_api_v1_user!
  before_action ->{
    set_recipe
  }, only: %i[ index create ]

  before_action ->{
    set_recipe_item
    set_recipe_from_recipe_item(@recipe_item)
  }, only: %i[ show destroy ]
  
  before_action -> {
    share_data(@recipe)
  }

  # GET /api/v1/recipes/1/recipe_items.json
  def index
    @recipe_items = @recipe.recipe_items
    render json: { status: 'SUCCESS', message: 'Loaded recipe_item', data: @recipe_items }
  end

  # GET /api/v1/recipes/1/recipe_items/1.json
  def show
    render json: { status: 'SUCCESS', message: 'Loaded recipe_item', data: @recipe_item }
  end

  # POST /api/v1/recipes/1/_recipe_items.json
  def create
    @recipe_item = @recipe.recipe_items.build(recipe_params)
    item = @recipe_item.item

    if @recipe_item.weight.nil?
      @recipe_item.weight = (@recipe_item.kcal / item.kcal) * item.weight
    else
      @recipe_item.kcal   = (@recipe_item.weight / item.weight) * item.kcal
    end

    if @recipe_item.save
      @recipe.add_nutrients(@recipe_item)
      render json: { status: 'SUCCESS', data: @recipe_item }
    else
      render json: { status: 'ERROR', data: @recipe_item.errors }
    end
  end

  # PATCH/PUT /recipe_items/1.json
  # def update
  #   if @recipe_item.update(recipe_item_params)
  #     render :show, status: :ok, location: @recipe_item
  #   else
  #     render json: @recipe_item.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /api/v1/recipes/1/recipe_items/1.json
  def destroy
    @recipe.sub_nutrients(@recipe_item)
    @recipe_item.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the recipe_item', data: @recipe_item }
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

    # Only allow a list of trusted parameters through.
    def recipe_item_params
      params.fetch(:recipe_item, {}).permit(:item_id, :kcal, :weight)
    end

end
