class Book < ApplicationRecord
  has_many   :rentals, dependent: :destroy
  belongs_to :category

  attachment :image

end
