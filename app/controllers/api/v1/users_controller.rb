class Api::V1::UsersController < ApplicationController
  before_action :authenticate_api_v1_user!, only: :show

  def show_me
    render json: { status: 'SUCCESS', message: 'Loaded current_user', data: current_api_v1_user }
  end
end
