FactoryBot.define do
  factory :merchant do
    title { Faker::Merchant.name }
  end
end
