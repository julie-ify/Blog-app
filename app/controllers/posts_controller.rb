class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.includes(:posts).find(params[:user_id])
  end

  def show
    @user = @user = User.find(params[:user_id])
    @post = @user.posts.includes(:comments, :likes).find(params[:id])
  end

  def new
    @current = current_user
  end

  def create
    new_post = current_user.posts.build(post_params)

    respond_to do |format|
      format.html do
        if new_post.save
          redirect_to user_post_path(new_post.author_id, new_post.id), notice: 'Post created successfully'
        else
          render :new, alert: 'Post not created. Please try again!'
        end
      end
    end
  end

  def destroy
    @user = current_user
    @post = @user.posts.find(params[:id])
    @post.comments.destroy_all
    @post.likes.destroy_all
    @post.destroy
    redirect_to user_posts_path(@user.id), notice: 'Post deleted'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
