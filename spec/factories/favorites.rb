FactoryBot.define do
  factory :favorite do
    association :event
    association :user
  end
end
