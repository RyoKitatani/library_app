class Book < ApplicationRecord
  has_many   :rentals, dependent: :destroy
  belongs_to :category

  attachment :image

  validates :title, presence: true, length: {maximum: 100}
  validates :isbn, presence: true, length: { is: 13}
  validates :auther, presence: true, length: {maximum: 20 }
  validates :publisher, presence: true, length: {maximum: 20 }
  validates :volume, presence: true, length: {maximum: 3 }
  validates :stock_num, presence: true, length: {maximum: 1 }

  def rental_status
    if stock_num == 0
       "貸出中"
    else
      "貸出可能" & "在庫数：#{stock_num}"
    end
  end

end
