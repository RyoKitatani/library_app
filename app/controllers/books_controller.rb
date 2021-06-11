class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def new
    @book = Book.new

    #書籍検索APIの処理
    if params[:keyword].present?
      require 'net/http'
      url = 'https://www.googleapis.com/books/v1/volumes?q='
      request = url + params[:keyword]
      enc_str = URI.encode(request)
      uri = URI.parse(enc_str)
      json = Net::HTTP.get(uri)
      @bookjson = JSON.parse(json)

      count = 10
      @books = Array.new(count).map{Array.new(7)}
      count.times do |x|
        @books[x][0] = @bookjson.dig("items", x, "volumeInfo", "title")
        @books[x][1] = @bookjson.dig("items", x, "volumeInfo", "imageLinks", "thumbnail")
        @books[x][2] = @bookjson.dig("items", x, "volumeInfo", "authors")
        @books[x][2] = @books[x][2].join(',') if @books[x][2] #複数著者をカンマで区切る
        @books[x][3] = @bookjson.dig("items", x, "volumeInfo", "publisher")
        @books[x][4] = @bookjson.dig("items", x, "volumeInfo", "publishedDate")
        @books[x][5] = @bookjson.dig("items", x, "volumeInfo", "industryIdentifiers", 1, "identifier")
        @books[x][6] = @bookjson.dig("items", x, "volumeInfo", "pageCount")
      end
    end

      @title = params[:title] if params[:title].present?
      @code = params[:code] if params[:code].present?
      @author = params[:author] if params[:author].present?
      @publisher = params[:publisher] if params[:publisher].present?
      @published_date = params[:publishedDate] if params[:publishedDate].present?
      @img = params[:img] if params[:img].present?
      @page = params[:pageCount] if params[:pageCount].present?
  end

  def show
    @book = Book.find(params[:id])
    @rental = Rental.find_by(user_id: current_user.id)
  end

  def create
    @book = Book.new(books_params)
    if @book.save
      flash.now[:success] = "書籍の登録が完了しました。"
      redirect_to book_path(@book)
    else
      render :new
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
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash.now[:success] = "書籍情報を削除しました。"
      redirect_to books_path
    else
      render :show
    end
  end

  def search
    @books = Book.search(params[:keyword])
  end

  private

  def books_params
    params.require(:book).permit(:title, :isbn, :image_url, :author, :publisher, :published_date, :category_id, :volume, :stock_num)
  end

end
