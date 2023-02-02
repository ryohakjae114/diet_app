class Api::V1::MySetsController < ApplicationController

  before_action ->{
    set_my_set
    data_owner(@my_set)
  }, only: %i[ show update destroy ]

  # GET /api/v1/my_sets
  # GET /api/v1/my_sets.json
  def index
    @my_sets = current_api_v1_user.my_sets
    render json: { status: 'SUCCESS', message: 'Loaded recipes', data: @my_sets }
  end

  # GET /api/v1/my_sets/1
  # GET /api/v1/my_sets/1.json
  def show
    render json: { status: 'SUCCESS', message: 'Loaded recipe', data: @my_set }
  end

  # POST /api/v1/my_sets
  # POST /api/v1/my_sets.json
  def create
    @my_set = current_api_v1_user.my_sets.build(my_set_params)

    if @my_set.save
      render json: { status: 'SUCCESS', data: @my_set }
    else
      render json: { status: 'ERROR', data: @my_set.errors }
    end
  end

  # PATCH/PUT /api/v1/my_sets/1
  # PATCH/PUT /api/v1/my_sets/1.json
  def update
    if @my_set.update(my_set_params)
      render json: { status: 'SUCCESS', message: 'Updated the my_recipe', data: @my_set }
    else
      render json: { status: 'ERROR', message: 'Not updated', data: @my_set.errors }
    end
  end

  # DELETE /api/v1/my_sets/1
  # DELETE /api/v1/my_sets/1.json
  def destroy
    @my_set.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the my_recipe', data: @my_set }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_my_set
      @my_set = MySet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def my_set_params
      params.fetch(:my_set, {}).permit(:name)
    end
end
