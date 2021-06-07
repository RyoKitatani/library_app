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
  email = "example#{n + 1}@gmail.com"
  password = "123456"
  User.create!(name: name,
            email: email,
            password: password,
            password_confirmation: password)
end

10.times do |n|
  name = Faker::Book.genre
  Category.create!(name: name)
end


Book.create!(title: Faker::Book.title,
             isbn: Faker::Number.number(digits: 13 ),
             author: Faker::Book.author,
             publisher: Faker::Book.publisher,
             published_date: Time.now,
             category_id: 1,
             volume: 10,
             stock_num: 0)

10.times do |n|
  title = Faker::Book.title
  isbn =  Faker::Number.number(digits:13 )
  publisher = Faker::Book.publisher
  author = Faker::Book.author
  Book.create!(title: title,
              isbn: isbn,
              publisher: publisher,
              author: author,
              published_date: Time.now,
              volume: 10,
              category_id: n + 1,
              stock_num: 1
              )
end