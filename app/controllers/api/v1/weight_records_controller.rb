class Api::V1::WeightRecordsController < ApplicationController
  before_action :authenticate_api_v1_user!

  before_action ->{
    set_weight_record
    data_owner(@weight_record)
  }, only: %i[ show destroy ]

  # GET /api/v1/weight_records
  # GET /api/v1/weight_records.json
  def index
    @weight_records = current_api_v1_user.weight_records
    render json: { status: 'SUCCESS', message: 'Loaded weight_records', data: @weight_records }
  end

  # GET /api/v1/weight_records/1
  # GET /api/v1/weight_records/1.json
  def show
    render json: { status: 'SUCCESS', message: 'Loaded the weight_record', data: @weight_record }
  end

  # POST /api/v1/weight_records
  # POST /api/v1/weight_records.json
  def create
    user = current_api_v1_user
    @weight_record = user.weight_records.build(weight_record_params)

    if @weight_record.save
      user.update_column(:weight, @weight_record.weight)
      render json: { status: 'SUCCESS', data: @weight_record }
    else
      render json: { status: 'ERROR', data: @weight_record.errors }
    end
  end

  # PATCH/PUT /api/v1/weight_records/1
  # PATCH/PUT /api/v1/weight_records/1.json
  # def update
  #   if @weight_record.update(weight_record_params)
  #     render :show, status: :ok, location: @weight_record
  #   else
  #     render json: @weight_record.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /api/v1/weight_records/1
  # DELETE /api/v1/weight_records/1.json
  def destroy
    @weight_record.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the weight_record', data: @weight_record }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weight_record
      @weight_record = WeightRecord.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def weight_record_params
      params.fetch(:weight_record, {}).permit(:weight)
    end
end
