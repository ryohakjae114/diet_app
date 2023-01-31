class Api::V1::PostsController < ApplicationController
  protect_from_forgery

  before_action :authenticate_api_v1_user!
  before_action :can_use_diary
  before_action :have_own_diary, only: %i[ create update destroy ]
  before_action :set_post, only: %i[ show update destroy ]
  before_action ->{
    data_owner(@post)
  }, only: %i[ update destroy ]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all_public_posts
    render json: { status: 'SUCCESS', message: 'Loaded the posts', data: @posts }
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    if @post.user == current_api_v1_user || @post.public?
      render json: { status: 'SUCCESS', message: 'Loaded the post', data: @post }
    else
      render json: { status: 'ERROR', message: 'Not public diary', data: @post }
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_api_v1_user.posts.build(post_params)

    if @post.save
      render json: { status: 'SUCCESS', data: @post }
    else
      render json: { status: 'ERROR', @post_comment.errors }
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if @post.update(post_params)
      render json: { status: 'SUCCESS', message: 'Updated the post', data: @post }
    else
      render json: { status: 'ERROR', message: 'Not updated the post', data: @post.errors }
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the post', data: @post }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.fetch(:post, {}).permit(:text)
    end
end
