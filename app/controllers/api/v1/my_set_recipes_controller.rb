class Api::V1::MySetRecipesController < ApplicationController
  protect_from_forgery

  before_action :authenticate_api_v1_user!
  before_action :set_my_set,        only: %i[ index create ]
  before_action :set_my_set_recipe, only: %i[ show update destroy ]

  # GET /api/v1/my_set_recipes
  # GET /api/v1/my_set_recipes.json
  def index
    @my_set_recipes = @my_set_recipe.my_set_recipes
    render json: { status: 'SUCCESS', message: 'Loaded recipes', data: @my_set_recipes }
  end

  # GET /api/v1/my_set_recipes/1
  # GET /api/v1/my_set_recipes/1.json
  def show
    render json: { status: 'SUCCESS', message: 'Loaded recipe', data: @my_set_recipe }
  end

  # POST /api/v1/my_set_recipes
  # POST /api/v1/my_set_recipes.json
  def create
    @my_set_recipe = @my_set_recipe.build(my_set_recipe_params)

    if @my_set_recipe.save
      render json: { status: 'SUCCESS', data: @my_set_recipe }
    else
      render json: { status: 'ERROR', data: @my_set_recipe.errors }
    end
  end

  # PATCH/PUT /api/v1/my_set_recipes/1
  # PATCH/PUT /api/v1/my_set_recipes/1.json
  def update
    if @my_set_recipe.update(my_set_recipe_params)
      render json: { status: 'SUCCESS', message: 'Updated the my_recipe', data: @my_set_recipe }
    else
      render json: { status: 'ERROR', message: 'Not updated', data: @my_set_recipe.errors }
    end
  end

  # DELETE /api/v1/my_set_recipes/1
  # DELETE /api/v1/my_set_recipes/1.json
  def destroy
    @my_set_recipe.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the my_recipe', data: @my_set_recipe }
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_my_set
      @my_set = MySet.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_my_set_recipe
      @my_set_recipe = MySetRecipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def my_set_recipe_params
      params.require(:my_set_recipe).permit(:recipe_id, :count)
    end
end
