FactoryBot.define do
  factory :word do
    word             {Faker::Lorem.characters(number: 10)}
    meaning          {Faker::Lorem.characters(number: 10)}
    correct_rate     {}
    correct_count    {Faker::Number.between(from: 1 ,to: 100)}
    uncorrect_count  {Faker::Number.between(from: 1 ,to: 100)}
    association :user 
    association :tank
  end
end
