class Api::V1::UsersController < Api::V1::ApiController
  load_and_authorize_resource

  def index
    @users = User.all
    render json: @users, status: 200
  end

  def show
    @user = User.find(params[:id])
    render json: { success: true, data: { user: @user, message: 'user retrieved succeffully' } }
  end
end
