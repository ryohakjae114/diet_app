class Api::V1::RecipesController < ApplicationController
  protect_from_forgery

  before_action :authenticate_api_v1_user!
  before_action ->{
    set_recipe
    share_data(@recipe)
  }, only: :show

  # GET /api/v1/recipes
  # GET /api/v1/recipes.json
  def index
    @recipes = Recipe.where(user_id: nil)
  end

  # GET /api/v1/recipes/1
  # GET /api/v1/recipes/1.json
  def show
    render json: { status: 'SUCCESS', message: 'Loaded the my_recipe', data: @recipe }
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.fetch(:recipe, {})
    end
end
