class Api::V1::RelationshipsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_user

  def create
    current_api_v1_user.follow(@user)
    render json: { status: 'SUCCESS', message: 'Followed user', data: @user }
  end

  def destroy
    current_api_v1_user.unfollow(@user)
    render json: { status: 'SUCCESS', message: 'Unfollowed user', data: @user }
  end

  private

    def set_user
      @user = User.find(params[:followed_id])
    end
end
