class Api::V1::DiariesController < ApplicationController
  
  before_action :can_use_diary
  before_action :set_diary, only: %i[ show update destroy ]
  before_action ->{
    data_owner(@diary)
  }, only: %i[ update destroy ]

  # GET /api/v1/diaries
  # GET /api/v1/diaries.json
  def index
    @diaries = Diary.all
    render json: { status: 'SUCCESS', message: 'Loaded the diaries', data: @diaries }
  end

  # GET /api/v1/diaries/1
  # GET /api/v1/diaries/1.json
  def show
    if @diary.user == current_api_v1_user || @diary.public_diary?
      render json: { status: 'SUCCESS', message: 'Loaded the diary', data: @diary }
    else
      render json: { status: 'ERROR', message: 'Not public diary'}
    end
  end

  # POST /api/v1/diaries
  # POST /api/v1/diaries.json
  def create
    @diary = current_api_v1_user.build_diary(diary_params)

    if @diary.save
      render json: { status: 'SUCCESS', data: @diary }
    else
      render json: { status: 'ERROR', data: @diary.errors }
    end
  end

  # PATCH/PUT /api/v1/diaries/1
  # PATCH/PUT /api/v1/diaries/1.json
  def update
    if @diary.update(diary_params)
      render json: { status: 'SUCCESS', message: 'Updated the diary', data: @diary }
    else
      render json: { status: 'ERROR', message: 'Not updated the diary', data: @diary.errors }
    end
  end

  # DELETE /api/v1/diaries/1
  # DELETE /api/v1/diaries/1.json
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
      params.fetch(:diary, {}).permit(:introduction, :icon, :public_diary, :public_body)
    end
end
