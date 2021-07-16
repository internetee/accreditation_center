# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
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

3.times do
    category = Category.create(title: Faker::Lorem.words(rand(1..2)).join(' '), quiz_id: quiz.id)
    6.times do
        question = Question.create(title: (Faker::Lorem.words(rand(2..10)) << '?').join(' '), category_id: category.id )
        3.times do
            Answer.create(title_en: Faker::Lorem.words(rand(2..10)).join(' '),
                          title_ee: Faker::Lorem.words(rand(2..10)).join(' '),
                          question_id: question.id )   
        end
        Answer.create(title_en: Faker::Lorem.words(rand(2..10)).join(' '),
                          title_ee: Faker::Lorem.words(rand(2..10)).join(' '),
                          question_id: question.id,
                          correct: true ) 
    end
end