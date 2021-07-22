require 'faker'

User.destroy_all
Quiz.destroy_all
Category.destroy_all
Question.destroy_all
Answer.destroy_all


User.create! do |u|
        u.email     = 'super@admin.ee'
        u.password  = 'password'
        u.superadmin_role = true
    end

quiz = Quiz.create(title: Faker::Lorem.words(rand(1..4)).join(' '))

3.times do |i|
    category = Category.create(title: Faker::Lorem.words(rand(1..2)).join(' '), quiz_id: quiz.id)
    question_type = i 
    6.times do
        question = Question.create!(title: (Faker::Lorem.words(rand(2..10)) << '?').join(' '), category_id: category.id, question_type: question_type)
        3.times do
            Answer.create!(title_en: Faker::Lorem.words(rand(2..10)).join(' '),
                          title_ee: Faker::Lorem.words(rand(2..10)).join(' '),
                          question_id: question.id )   
        end
        Answer.create!(title_en: Faker::Lorem.words(rand(2..10)).join(' '),
                          title_ee: Faker::Lorem.words(rand(2..10)).join(' '),
                          question_id: question.id,
                          correct: true ) 
    end
end