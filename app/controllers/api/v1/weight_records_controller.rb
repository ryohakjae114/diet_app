class Api::V1::WeightRecordsController < ApplicationController
  protect_from_forgery

  before_action ->{
    set_weight_record
    data_owner(@weight_record)
  }, only: %i[ show destroy ]

  # GET /weight_records
  # GET /weight_records.json
  # def index
  #   @weight_records = WeightRecord.all
  # end

  # GET /weight_records/1
  # GET /weight_records/1.json
  def show
    render json: { status: 'SUCCESS', message: 'Loaded the weight_record', data: @weight_record }
  end

  # POST /weight_records
  # POST /weight_records.json
  def create
    @weight_record = current_api_v1_user.weight_records.build(weight_record_params)

    if @weight_record.save
      render json: { status: 'SUCCESS', data: @weight_record }
    else
      render json: { status: 'ERROR', data: @weight_record.errors }
    end
  end

  # PATCH/PUT /weight_records/1
  # PATCH/PUT /weight_records/1.json
  # def update
  #   if @weight_record.update(weight_record_params)
  #     render :show, status: :ok, location: @weight_record
  #   else
  #     render json: @weight_record.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /weight_records/1
  # DELETE /weight_records/1.json
  def destroy
    @weight_record.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the my_item', data: @weight_record }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weight_record
      @weight_record = WeightRecord.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def weight_record_params
      params.require(:weight_record).permit(:weight)
    end
end
