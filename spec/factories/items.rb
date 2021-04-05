FactoryBot.define do
  factory :item do
    name { Faker::Games::Zelda.item }
    description { Faker::Games::Zelda.location }
    unit_price {Faker::Number.decimal(l_digits: 2)}
    merchant
  end
  # factory :merchant do
  #   name { Faker::Games::Zelda.character }
  #   factory :merchant_with_items do
  # # posts_count is declared as a transient attribute available in the
  # # callback via the evaluator
  #   transient do
  #     items_count { 5 }
  #   end
  #
  #   after(:create) do |merchant, evaluator|
  #     create_list(:post, evaluator.posts_count, merchant: merchant)
  #
  #     # You may need to reload the record here, depending on your application
  #     merchant.reload
  #   end
  # end
end
