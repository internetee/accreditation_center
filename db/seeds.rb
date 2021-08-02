require 'faker'

User.destroy_all
Quiz.destroy_all
Category.destroy_all
Question.destroy_all
Answer.destroy_all


admin = User.create! do |u|
        u.email = 'super@admin.ee'
        u.username     = 'superadmin'
        u.password  = 'password'
        u.superadmin_role = true
    end

user_one = User.create! do |u|
        u.email = 'user@one.ee'
        u.username     = 'user_one'
        u.password  = 'password'
        u.superadmin_role = false
    end

user_two = User.create! do |u|
        u.email = 'user@two.ee'
        u.username     = 'user_two'
        u.password  = 'password'
        u.superadmin_role = false
    end

quiz_one = Quiz.create(title: Faker::Lorem.words(rand(1..4)).join(' '), user: user_one)

3.times do |i|
    category = Category.create(title: Faker::Lorem.words(rand(1..2)).join(' '), quiz_id: quiz_one.id)
    question_type = i 
    6.times do
        question = Question.create!(title: (Faker::Lorem.words(rand(2..10)) << '?').join(' '), category_id: category.id, question_type: question_type)
        3.times do
            Answer.create!(title_en: Faker::Lorem.words(rand(2..10)).join(' '),
                          title_ee: Faker::Lorem.words(rand(2..10)).join(' '),
                          question_id: question.id,
                          category_id: category.id,
                          correct: false )
        end
        Answer.create!(title_en: Faker::Lorem.words(rand(2..10)).join(' '),
                          title_ee: Faker::Lorem.words(rand(2..10)).join(' '),
                          question_id: question.id,
                          category_id: category.id,
                          correct: true )
    end
end

quiz_two = Quiz.create(title: Faker::Lorem.words(rand(1..4)).join(' '), user: user_one)

3.times do |i|
    category = Category.create(title: Faker::Lorem.words(rand(1..2)).join(' '), quiz_id: quiz_two.id)
    question_type = i 
    6.times do
        question = Question.create!(title: (Faker::Lorem.words(rand(2..10)) << '?').join(' '), category_id: category.id, question_type: question_type)
        3.times do
            Answer.create!(title_en: Faker::Lorem.words(rand(2..10)).join(' '),
                          title_ee: Faker::Lorem.words(rand(2..10)).join(' '),
                          category_id: category.id,
                          question_id: question.id,
                          correct: false )
        end
        Answer.create!(title_en: Faker::Lorem.words(rand(2..10)).join(' '),
                          title_ee: Faker::Lorem.words(rand(2..10)).join(' '),
                          category_id: category.id,
                          question_id: question.id,
                          correct: true )
    end
end

quiz_three = Quiz.create(title: Faker::Lorem.words(rand(1..4)).join(' '), user: user_two)

3.times do |i|
    category = Category.create(title: Faker::Lorem.words(rand(1..2)).join(' '), quiz_id: quiz_three.id)
    question_type = i 
    6.times do
        question = Question.create!(title: (Faker::Lorem.words(rand(2..10)) << '?').join(' '), category_id: category.id, question_type: question_type)
        3.times do
            Answer.create!(title_en: Faker::Lorem.words(rand(2..10)).join(' '),
                          title_ee: Faker::Lorem.words(rand(2..10)).join(' '),
                          category_id: category.id,
                          question_id: question.id,
                          correct: false )
        end
        Answer.create!(title_en: Faker::Lorem.words(rand(2..10)).join(' '),
                          title_ee: Faker::Lorem.words(rand(2..10)).join(' '),
                          category_id: category.id,
                          question_id: question.id,
                          correct: true )
    end
end