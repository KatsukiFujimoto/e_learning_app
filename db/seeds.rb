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



# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }


# カテゴリー
30.times do
  title = Faker::Lorem.word.capitalize
  content = Faker::Lorem.paragraph(2)
  Category.create!(title: title, description: content)
end


# ワード&アンサー
5.times do 
  word_lists = Faker::Lorem.words(3)
  word_content = word_lists[0]
  answer_content0 = word_lists[0]
  correctness0 = 'true'
  answer_content1 = word_lists[1]
  correctness1 = 'false'
  answer_content2 = word_lists[2]
  correctness2 = 'false'
  params = { word: { content: word_content, word_answers_attributes: [ { content: answer_content0, correct: correctness0 },
                                                                    { content: answer_content1, correct: correctness1 },
                                                                    { content: answer_content2, correct: correctness2 } ] } }
  Category.first.words.create(params[:word])
end

60.times do 
  word_lists = Faker::Lorem.words(3)
  word_content = word_lists[0]
  answer_content0 = word_lists[1]
  correctness0 = 'false'
  answer_content1 = word_lists[0]
  correctness1 = 'true'
  answer_content2 = word_lists[2]
  correctness2 = 'false'
  params = { word: { content: word_content, word_answers_attributes: [ { content: answer_content0, correct: correctness0 },
                                                                    { content: answer_content1, correct: correctness1 },
                                                                    { content: answer_content2, correct: correctness2 } ] } }
  Category.second.words.create(params[:word])
end

60.times do 
  word_lists = Faker::Lorem.words(3)
  word_content = word_lists[0]
  answer_content0 = word_lists[2]
  correctness0 = 'false'
  answer_content1 = word_lists[1]
  correctness1 = 'false'
  answer_content2 = word_lists[0]
  correctness2 = 'true'
  params = { word: { content: word_content, word_answers_attributes: [ { content: answer_content0, correct: correctness0 },
                                                                    { content: answer_content1, correct: correctness1 },
                                                                    { content: answer_content2, correct: correctness2 } ] } }
  Category.third.words.create(params[:word])
end

(4..30).each do |i|
  5.times do 
    word_lists = Faker::Lorem.words(3)
    word_content = word_lists[0]
    answer_content0 = word_lists[0]
    correctness0 = 'true'
    answer_content1 = word_lists[1]
    correctness1 = 'false'
    answer_content2 = word_lists[2]
    correctness2 = 'false'
    params = { word: { content: word_content, word_answers_attributes: [ { content: answer_content0, correct: correctness0 },
                                                                      { content: answer_content1, correct: correctness1 },
                                                                      { content: answer_content2, correct: correctness2 } ] } }
    Category.find(i).words.create(params[:word])
  end
end

