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
    @user = User.find(params[:id])
    @user.update(users_params)
    flash.now[:success] = "プロフィールを更新しました。"
    redirect_to user_path(@user)
  end

  private 

  def users_params
    params.require(:user).permit(:name, :email, :image, :password, :password_confirmation )
  end
end
