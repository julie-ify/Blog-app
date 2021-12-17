class Api::V1::PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @posts = Post.all
    render json: @posts, status: 200
  end
end
