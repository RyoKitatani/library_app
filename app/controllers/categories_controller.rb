class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all
    @category = Category.new
  end

  def show
    @category = Category.find(params[:id])
    @books = @category.books
  end

  def create
    @category = Category.new(categories_params)
    if @category.save
      flash[:success] = "ジャンルを追加しました"
      redirect_to categories_path
    else
      @categories = Category.all
      render :index
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(categories_params)
      flash[:success] = "カテゴリーの更新をしました。"
      redirect_to categories_path
    else
      flash[:danger] = "カテゴリーの更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      flash[:success] = "ジャンルを削除しました。"
      redirect_to categories_path
    else
      @categories = Category.all
      flash[:danger] = "カテゴリーを削除できませんでした。"
      render :index
    end
  end

  private

  def categories_params
    params.require(:category).permit(:name)
  end

end
