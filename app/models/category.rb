class Category < ApplicationRecord

  has_many :books
  validates :name, presence: true, length: {maximum: 30}
  
end
