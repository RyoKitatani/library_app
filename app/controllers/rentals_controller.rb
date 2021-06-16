class RentalsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rentals = Rental.order(rental_date: :asc)
  end

  def create
    @book = Book.find(params[:book_id])
    @rental = current_user.rentals.new(book_id: @book.id, user_id: current_user.id, rental_date: DateTime.now, due_date: DateTime.now + 14 )
    @book.increment!(:stock_num, -1)
    @rental.save
    flash[:success] = "#{@book.title}を借りました。"
    redirect_to book_path(@book)
  end

  def destroy
    @book = Book.find(params[:book_id])
    @rental = current_user.rentals.find_by(book_id: @book.id)
    @book.increment!(:stock_num, 1)
    @rental.destroy
    flash[:success] = "#{@book.title}を返却しました。"
    redirect_to request.referer
  end

end
