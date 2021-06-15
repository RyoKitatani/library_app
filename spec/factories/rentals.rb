FactoryBot.define do
  factory :rental do
    user_id { 1 }
    book_id { 1 }
    rental_date { DateTime.now }
    due_date { DateTime.now + 7 }
  end
end