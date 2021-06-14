class Category < ApplicationRecord

  has_many :books
  validates :name, presence: true, uniqueness:true, length: {maximum: 30}
end
