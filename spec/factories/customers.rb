FactoryBot.define do
  factory :customer do
    id {10}
    first_name { Faker::Games::Pokemon.name }
    last_name { Faker::Games::Pokemon.name }
  end
end
