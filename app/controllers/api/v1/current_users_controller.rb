class Api::V1::CurrentUsersController < ApplicationController
  def show
    if current_api_v1_user
      render json: { status: 'SUCCESS', message: 'Loaded user', data: current_api_v1_user }
    else
      render json: { status: 'ERROR', message: 'no' }
  end
end
