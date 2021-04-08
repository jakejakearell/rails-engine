FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity { 12}
    unit_price { 10.00}
  end
end
