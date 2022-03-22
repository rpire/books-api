class Api::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @users = User.includes(:books)

    render json: @users.map { |user| { user: user, books: user.books } }
  end

  def show
    render json: @user
  end

  def update
    if current_user.role == 'admin'
      edit(admin_params)
    else
      edit(user_params)
    end
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def edit(params)
    if @user.update(params)
      render json: @user, status: :accepted
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def user_params
    params.require(:user).permit(:name, :bio, :icon, :password)
  end

  def admin_params
    params.require(:user).permit(:name, :bio, :icon, :password, :role)
  end
end
