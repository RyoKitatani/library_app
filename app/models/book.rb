class Book < ApplicationRecord
  has_many   :rentals, dependent: :destroy
  has_many   :bookmarks, dependent: :destroy
  belongs_to :category



  validates :title, presence: true, length: {maximum: 100}
  validates :author, presence: true, length: {maximum: 40 }
  validates :publisher, presence: true, length: {maximum: 40 }
  validates :volume, presence: true, length: {maximum: 3 }
  validates :stock_num, presence: true, length: {maximum: 1 }

  def rental_status
    if stock_num == 0
       "貸出中"
    else
      "貸出可能"
      "#{stock_num}冊貸出可能"
    end
  end

  def rentaled_by?(user)
    rentals.where(user_id: user.id).exists?
  end

  def bookmarked_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end

  def self.search(search)
    if search != ""
      Book.where(['title LIKE(?) OR isbn LIKE(?) OR author LIKE(?)  OR publisher LIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
      else
        Book.order('created_at DESC')
      end
  end

end
