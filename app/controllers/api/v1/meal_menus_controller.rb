class Api::V1::MealMenusController < ApplicationController

  before_action ->{
    set_meal
  }, only: %i[ index create ]

  before_action ->{
    set_meal_menu
    set_meal_from_meal_menu
  }, only: %i[ show update destroy ]

  before_action -> {
    data_owner(@meal)
  }

  # GET /api/v1/meals/1/meal_menus
  # GET /api/v1/meals/1/meal_menus.json
  def index
    @meal_menus = @meal.meal_menus
    render json: { status: 'SUCCESS', message: 'Loaded meal_menu', data: @meal_menus }
  end

  # GET /meal_menus/1
  # GET /meal_menus/1.json
  def show
    render json: { status: 'SUCCESS', message: 'Loaded my_recipe_item', data: @meal_menu }
  end

  # POST /meal/1/meal_menus
  # POST /meal/1/meal_menus.json
  def create
    @meal_menu = @meal.meal_menus.build(meal_menu_params)

    if @meal_menu.save
      render json: { status: 'SUCCESS', data: @meal_menu }
    else
      render json: { status: 'ERROR', data: @meal_menu.errors }
    end
  end

  # PATCH/PUT /meal_menus/1
  # PATCH/PUT /meal_menus/1.json
  def update
    if @meal_menu.update(meal_menu_params)
      render json: { status: 'SUCCESS', message: 'Updated the meal_menu', data: @meal_menu }
    else
      render json: { status: 'ERROR', message: 'Not updated', data: @meal_menu.errors }
    end
  end

  # DELETE /meal_menus/1
  # DELETE /meal_menus/1.json
  def destroy
    @meal_menu.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the meal_menu', data: @meal_menu }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal_menu
      @meal_menu = MealMenu.find(params[:id])
    end

    def set_meal_from_meal_menu
      @meal = @meal_menu.meal
    end

    # Only allow a list of trusted parameters through.
    def meal_menu_params
      params.fetch(:meal_menu, {}).permit(:recipe_id, :count)
    end
end
