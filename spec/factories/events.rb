FactoryBot.define do
  factory :event do
    name       { "東京駅フリーマーケット" }
    address    { "東京駅" }
    event_time { "10:00〜15:00" }
    association :user
  end
end
