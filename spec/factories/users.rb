FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email}
    password { "password" }
    password_confirmation { "password" }
    is_admin { false }
  end
end