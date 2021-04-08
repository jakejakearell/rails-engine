FactoryBot.define do
  factory :invoice do
    status {'packaged'}
    merchant_id {10}
    customer_id {10}
  end
end
