class UsersController < ApplicationController
  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  end

  private 

  def users_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation )
  end
end
