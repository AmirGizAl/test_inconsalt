FactoryBot.define do
  factory :player do
    name { "Player #{Faker::Number.unique.between(from: 1, to: 100)}" }
  end
end
