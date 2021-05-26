FactoryBot.define do
  factory :tank do
    tank_name {Faker::Lorem.characters(number: 10)}
    tank_icon {}
    association :user 
  end
end