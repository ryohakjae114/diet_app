class Api::V1::FavoritesController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_post,     only: %i[index create]
  before_action :set_favorite, only: %i[ show destroy]

  def index
    @favorites = @post.favorites
    render json: { status: 'SUCCESS', message: 'Loaded favorites', data:  @favorites }
  end

  def create
    @favorite = @post.favorites.build(user: current_api_v1_user)

    if @favorite.save
      render json: { status: 'SUCCESS', data: @favorite }
    else
      render json: { status: 'ERROR', data: @favorite.errors }
    end
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded favorite', data: @favorite }
  end

  def destroy
    @favorite.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the favorite', data: @favorite }
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def set_favorite
      @favorite = Favorite.find(params[:id])
    end
end
