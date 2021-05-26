FactoryBot.define do
  factory :user do
    username              {Faker::Name.initials(number: 3)}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
  end
end