FactoryBot.define do
  factory :merchant do
    name { Faker::Games::Pokemon.name }
  end
end
