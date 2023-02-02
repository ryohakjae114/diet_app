class Api::V1::RecipesController < ApplicationController
  
  before_action ->{
    set_recipe
    share_data(@recipe)
  }, only: :show

  # GET /api/v1/recipes
  # GET /api/v1/recipes.json
  def index
    @recipes = Recipe.where(user_id: nil)
    render json: { status: 'SUCCESS', message: 'Loaded recipes', data: @recipes }
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
end
