class BooksController < ApplicationController

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(books_params)
    if @book.save
      flash[:success] = "書籍の登録が完了しました。"
      redirect_to book_path(@book)
    else
      flash[:danger] = "書籍の登録に失敗しました"
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(books_params)
      flash[:success] = "書籍情報を更新しました。"
      redirect_to book_path(@book)
    else
      flash[:danger] = "書籍情報の更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:success] = "書籍情報を削除しました。"
      redirect_to root_path
    else
      flash[:danger] = "書籍情報の削除に失敗しました。"
      render :show
    end
  end

  private

  def books_params
    params.require(:book).permit(:title, :isbn, :image, :author, :publisher, :published_date, :category_id, :volume, :stock_num)
  end

end
