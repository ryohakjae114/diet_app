class Api::V1::MealsController < ApplicationController

  before_action ->{
    set_meal
    data_owner(@meal)
  }, only: %i[ show destroy ]

  # GET /api/v1/meals
  # GET /api/v1/meals.json
  def index
    @meals = current_api_v1_user.meals
    render json: { status: 'SUCCESS', message: 'Loaded the meal', data: @meals }
  end

  # GET /api/v1/meals/1
  # GET /api/v1/meals/1.json
  def show
    render json: { status: 'SUCCESS', message: 'Loaded the meal', data: @meal }
  end

  # POST /api/v1/meals
  # POST /api/v1/meals.json
  def create
    @meal = current_api_v1_user.meals.build(meal_params)

    if @meal.save
      render json: { status: 'SUCCESS', data: @meal }
    else
      render json: { status: 'ERROR', data: @meal.errors }
    end
  end

  # PATCH/PUT /api/v1/meals/1
  # PATCH/PUT /api/v1/meals/1.json
  # def update
  #   if @meal.update(meal_params)
  #     render :show, status: :ok, location: @meal
  #   else
  #     render json: @meal.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /api/v1/meals/1
  # DELETE /api/v1/meals/1.json
  def destroy
    @meal.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the meal', data: @meal }
  end

  private

    # Only allow a list of trusted parameters through.
    def meal_params
      params.fetch(:meal, {}).permit(:date, :timing, :comment)
    end
end
