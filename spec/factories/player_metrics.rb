FactoryBot.define do
  factory :player_metric do
    association :player
    association :metric
    association :match
    value { Faker::Number.between(from: 1, to: 100) }
  end
end
