FactoryBot.define do
  factory :event_schedule do
    event_date { Date.tomorrow }
    association :event
  end
end
