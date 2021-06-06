class HomesController < ApplicationController
  def top
    @books = Book.all
    @book = Book.new
  end
end
