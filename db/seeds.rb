# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(name: "Example User",
           email: "example@gmail.com",
           password: "123456",
           password_confirmation: "123456",
           is_admin: true)

5.times do |n|
  name = Faker::Name.name
  email = "example#{n + 1}@gmaill.com"
  password = "password"
  User.create!(name: name,
            email: email,
            password: password,
            password_confirmation: password)
end

5.times do |n|
  name = Faker::Book.genre
  Category.create!(name: name)
end


Book.create!(title: Faker::Book.title,
             isbn: 978 + Faker::Number.number(digits: 10 ),
             publisher: Faker::Book.publisher,
             category_id: 1,
             stock_num: 0)

5.times do |n|
  title = Faker::Book.title
  isbn =  978 + Faker::Number.number(digits: 10 )
  publisher = Faker::Book.publisher
  Book.create!(title: title,
              isbn: isbn,
              publisher: publisher,
              category_id: n + 1,
              stock_num: 1
              )
end