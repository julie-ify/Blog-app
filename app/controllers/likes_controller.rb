class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.create(author_id: current_user.id, post_id: @post.id)

    respond_to do |format|
      format.html do
        if @like.save
          redirect_to user_post_path(@post.author.id, @post.id), notice: 'Liked 👍'
        else
          redirect_to user_post_path(@post.author.id, @post.id), alert: 'Like not added'
        end
      end
    end
  end

  def destroy
    previous_url = request.env['HTTP_REFERER']
    like_to_delete = Like.find_by(author_id: params[:id])

    if like_to_delete.destroy
      flash[:notice] = 'Post unliked successfully!'
    else
      flash[:alert] = 'Unable to unlike this post'
    end
    redirect_to(previous_url)
  end
end
