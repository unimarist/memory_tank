FactoryBot.define do
  factory :question do
    question {Faker::Lorem.characters(number: 500)}
    answer_a {Faker::Lorem.characters(number: 500)}
    answer_b {Faker::Lorem.characters(number: 500)}
    answer_c {Faker::Lorem.characters(number: 500)}
    answer_d {Faker::Lorem.characters(number: 500)}
    correct_answer {'A'}
    description {Faker::Lorem.characters(number: 500)}
    correct_rate     {}
    correct_count    {Faker::Number.between(from: 1 ,to: 100)}
    uncorrect_count  {Faker::Number.between(from: 1 ,to: 100)}
    association :user 
    association :tank
  end
end
