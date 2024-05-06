FactoryBot.define do
  factory :metric do
    name { Faker::Lorem.unique.word }
  end
end

