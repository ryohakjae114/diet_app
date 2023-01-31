class Api::V1::PostCommentsController < ApplicationController
  protect_from_forgery

  before_action :authenticate_api_v1_user!
  before_action :can_use_post_comment
  before_action :have_own_post_comment,   only: %i[ create update destroy]
  before_action :set_post,         only: %i[ index create ]
  before_action :set_post_comment, only: %i[ show update destroy ]
  before_action :public_post,      only: :create
  before_action ->{
    data_owner(@post_comment)
  }, only: %i[ update destroy ]

  # GET /post_comments
  # GET /post_comments.json
  def index
    @post_comments = @post.post_comments
    render json: { status: 'SUCCESS', message: 'Loaded the post_comments', data: @post_comments }
  end

  # GET /post_comments/1
  # GET /post_comments/1.json
  def show
    render json: { status: 'SUCCESS', message: 'Loaded the post_comment', data: @post_comment }
  end

  # POST /post_comments
  # POST /post_comments.json
  def create
    @post_comment      = current_api_v1_user.build(post_comment_params)
    @post_comment.post = @post

    if @post_comment.save
      render json: { status: 'SUCCESS', data: @post_comment }
    else
      render json: { status: 'ERROR', data: @post_comment.errors }
    end
  end

  # PATCH/PUT /post_comments/1
  # PATCH/PUT /post_comments/1.json
  def update
    if @post_comment.update(post_comment_params)
      render json: { status: 'SUCCESS', message: 'Updated the post_comment', data: @post_comment }
    else
      render json: { status: 'ERROR', message: 'Not updated the post_comment', data: @post_comment.errors }
    end
  end

  # DELETE /post_comments/1
  # DELETE /post_comments/1.json
  def destroy
    @post_comment.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the post_comment', data: @post_comment }
  end

  private

    def public_post
      unless @post.public?
        render json: { status: "ERROR", message: "Not public post_comment"}
      end
    end

    def set_post
      @post = Post.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_post_comment
      @post_comment = postComment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_comment_params
      params.require(:post_comment, {}).permit(:text)
    end
end
