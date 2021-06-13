class UsersController < ApplicationController
  def index
    @users = User.all.order(name: :desc)
  end
  
  def show
    @user = User.find(params[:id])
    @bookmarks = @user.bookmarks
    @rentals =  @user.rentals
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
