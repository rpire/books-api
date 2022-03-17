class Api::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  before_action :authenticate_user!

  def index
    @users = User.all

    render json: @users.map { |user| { user: user, books: user.books } }
  end

  def show
    render json: @user
  end

  def update
    if @user.update(user_params)
      render json: @user, status: :accepted
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :bio, :icon, :email, :password)
  end
end
