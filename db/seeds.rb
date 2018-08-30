# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# ユーザー

User.create!(name: "chandler",
            email: "chanchan@icloud.com",
            password: "chanchan",
            password_confirmation: "chanchan",
            admin: true)
            
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@icloud.com"
  password = "password"
  User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password)
end

# カテゴリー
100.times do
  title = Faker::Lorem.word.capitalize
  content = Faker::Lorem.paragraph(2)
  Category.create!(title: title, description: content)
end


# リレーションシップ

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }