class Api::V1::CommentsController < ApplicationController
  load_and_authorize_resource

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments.all
    render json: @comments
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(text: comment_parameters[:text], author_id: current_user.id)

    if @comment.save
      render json: @comment
    else
      render json: @comment.errors, status: :bad_request, message: 'Failed to add comment'
    end
  end

  private

  def comment_parameters
    params.require(:comment).permit(:text)
  end
end
