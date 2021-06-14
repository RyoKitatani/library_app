class HomesController < ApplicationController
  def top
  end

  def guest_sign_in
    user = User.find_or_create_by!(email: 'guest@gmail.com') do |user|
      user.name = "ゲストユーザー"
       user.password = SecureRandom.urlsafe_base64
    end
    sign_in user
    redirect_to books_path, notice:'ゲストログインしました。'
  end

  def admin_sign_in
    user = User.find_or_create_by!(email: 'admin@gmail.com') do |user|
      user.name = "管理者"
      user.password = SecureRandom.urlsafe_base64
      user.is_admin = true
    end
    sign_in user
    redirect_to books_path, notice:'管理者ログインしました。'
  end

end
