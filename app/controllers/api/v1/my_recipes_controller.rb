class Api::V1::MyRecipesController < ApplicationController
  protect_from_forgery

  before_action :authenticate_api_v1_user!
  before_action ->{
    set_my_recipe
    check_data_owner(@my_recipe)
  }, only: %i[ show update destroy ]

  # GET /api/v1/my_recipes.json
  def index
    @my_recipes = current_api_v1_user.recipes
    render json: { status: 'SUCCESS', message: 'Loaded recipes', data: @my_recipes }
  end

  # GET /api/v1/my_recipes/1.json
  def show
    render json: { status: 'SUCCESS', message: 'Loaded recipes', data: @my_recipe }
  end

  # POST /api/v1/my_recipes.json
  def create
    @my_recipe = current_api_v1_user.recipes.build(my_recipe_params)

    if @my_recipe.save
      render json: { status: 'SUCCESS', data: @my_recipe }
    else
      render json: { status: 'ERROR', data: @my_recipe.errors }
    end
  end

  # PATCH/PUT /api/v1/my_recipes/1.json
  def update
    if @my_recipe.update(my_recipe_params)
      render json: { status: 'SUCCESS', message: 'Updated the my_recipe', data: @my_recipe }
    else
      render json: { status: 'ERROR', message: 'Not updated', data: @my_recipe.errors }
    end
  end

  # DELETE /api/v1/my_recipes/1.json
  def destroy
    @my_recipe.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the my_recipe', data: @my_recipe }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_my_recipe
      @my_recipe = Recipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def my_recipe_params
      params.fetch(:my_recipe, {}).permit(:img_url, :name, :cook_at)
    end
end
