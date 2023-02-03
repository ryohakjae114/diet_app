class Api::V1::ExerciseRecordsController < ApplicationController
  before_action :authenticate_api_v1_user!

  before_action ->{
    set_exercise_record
    data_owner(@exercise_record)
  }, only: %i[ show destroy ]

  def index
    @exercise_records = current_api_v1_user.exercise_records
    render json: { status: 'SUCCESS', message: 'Loaded exercise_records', data: @exercise_records }
  end

  def create
    @exercise_record = current_api_v1_user.exercise_records.build(exercise_record_params)

    if @exercise_record.save
      render json: { status: 'SUCCESS', data: @exercise_record }
    else
      render json: { status: 'ERROR', data: @exercise_record.errors }
    end
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded the exercise_record', data: @exercise_record }
  end

  def destroy
    @exercise_record.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the exercise_record', data: @exercise_record }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise_record
      @exercise_record = ExerciseRecord.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def exercise_record_params
      params.fetch(:exercise_record, {}).permit(:name, :kcal)
    end
end
