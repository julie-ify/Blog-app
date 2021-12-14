class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(text: comment_parameters[:text], author_id: current_user.id, post_id: @post.id)

    respond_to do |format|
      format.html do
        if @comment.save
          redirect_to user_post_path(@post.author.id, @post.id), notice: 'Comment created successfully'
        else
          redirect_to user_post_path(@post.author.id, @post.id), alert: 'Comment not created, try again!'
        end
      end
    end
  end

  def destroy
    previous_url = request.env['HTTP_REFERER']
    comment_to_delete = Comment.find(params[:id])

    if comment_to_delete.destroy
      flash[:notice] = 'Comment Deleted successfully!'
    else
      flash[:alert] = 'Unable to delete comment Try again later'
    end
    redirect_to(previous_url)
  end

  private

  def comment_parameters
    params.require(:comment).permit(:text)
  end
end
