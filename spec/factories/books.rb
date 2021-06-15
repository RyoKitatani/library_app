FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    isbn { Faker::Number.number(digits: 13 ) }
    author { Faker::Book.author }
    publisher { Faker::Book.publisher }
    published_date{ Time.now }
    category_id { 1 }
    volume { 10 }
    stock_num { 1 }
  end
end