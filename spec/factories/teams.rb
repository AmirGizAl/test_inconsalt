FactoryBot.define do
  factory :team do
    name { "Team #{Faker::Number.unique.between(from: 1, to: 100)}" }
  end
end
