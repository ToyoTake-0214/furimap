FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "runteq_#{n}@example.com" }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    role { :organizer }
  end
end
