class Api::V1::MealsController < ApplicationController
  protect_from_forgery

  before_action :authenticate_api_v1_user!
  before_action ->{
    set_meal
    data_owner(@meal)
  }, only: %i[ show create destroy ]

  # GET /meals
  # GET /meals.json
  def index
    @meals = current_api_v1_user.meals
    render json: { status: 'SUCCESS', message: 'Loaded the meal', data: @meals }
  end

  # GET /meals/1
  # GET /meals/1.json
  def show
    render json: { status: 'SUCCESS', message: 'Loaded the meal', data: @meal }
  end

  # POST /meals
  # POST /meals.json
  def create
    @meal = current_api_v1_user.meals.build(meal_params)

    if @meal.save
      render json: { status: 'SUCCESS', data: @meal }
    else
      render json: { status: 'ERROR', data: @meal.errors }
    end
  end

  # PATCH/PUT /meals/1
  # PATCH/PUT /meals/1.json
  # def update
  #   if @meal.update(meal_params)
  #     render :show, status: :ok, location: @meal
  #   else
  #     render json: @meal.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /meals/1
  # DELETE /meals/1.json
  def destroy
    @meal.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the meal', data: @meal }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meal_params
      params.require(:meal).permit(:user_id, :date, :timing, :comment)
    end
end
