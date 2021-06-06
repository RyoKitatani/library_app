class Book < ApplicationRecord
  has_many   :rentals, dependent: :destroy
  belongs_to :category

  attachment :image

  def rental_status
    if stock_num == 0
       "貸出中"
    else
      "貸出可能"
    end
  end

end
