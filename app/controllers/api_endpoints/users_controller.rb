class Api::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.all
    render json: { success: true, data: { users: @users, message: "users retrieved succeffully" } }
  end
end