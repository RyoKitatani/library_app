class BooksController < ApplicationController

  def show
    @book = Book.find(params:[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def destroy
  end

  private

  def books_params
    params.require(:book).permit(:title, :image)
  end

end
