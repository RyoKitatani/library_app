class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @bookmark = current_user.bookmarks.new(book_id: @book.id)
    @bookmark.save
    redirect_to request.referer
  end

  def destroy
    @book = Book.find(params[:book_id])
    @bookmark = current_user.bookmarks.find_by(book_id: @book.id)
    @bookmark.destroy
    redirect_to request.referer
  end

end
