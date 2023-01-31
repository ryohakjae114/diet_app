class Api::V1::DiariesController < ApplicationController
  protect_from_forgery

  before_action :authenticate_api_v1_user!
  before_action :can_use_diary
  before_action :set_diary, only: %i[ show update destroy ]
  before_action ->{
    data_owner(@diary)
  }, only: %i[ update destroy ]

  # GET /diaries
  # GET /diaries.json
  def index
    @diaries = Diary.all
    render json: { status: 'SUCCESS', message: 'Loaded the diaries', data: @diaries }
  end

  # GET /diaries/1
  # GET /diaries/1.json
  def show
    if @diary.user == current_api_v1_user || @diary.public_diary?
      render json: { status: 'SUCCESS', message: 'Loaded the diary', data: @diary }
    else
      render json: { status: 'ERROR', message: 'Not public diary', data: @diary }
    end
  end

  # POST /diaries
  # POST /diaries.json
  def create
    @diary = current_api_v1_user.build_diary(diary_params)

    if @diary.save
      render json: { status: 'SUCCESS', data: @diary }
    else
      render json: { status: 'ERROR', data: @diary.errors }
    end
  end

  # PATCH/PUT /diaries/1
  # PATCH/PUT /diaries/1.json
  def update
    if @diary.update(diary_params)
      render json: { status: 'SUCCESS', message: 'Updated the diary', data: @diary }
    else
      render json: { status: 'ERROR', message: 'Not updated the diary', data: @diary.errors }
    end
  end

  # DELETE /diaries/1
  # DELETE /diaries/1.json
  def destroy
    @diary.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the diary', data: @diary }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diary
      @diary = Diary.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def diary_params
      params.require(:diary, {}).permit(:introduction, :icon, :public_diary, :public_body)
    end
end
