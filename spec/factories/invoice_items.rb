FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.within(range: 1..50) }
    unit_price { Faker::Commerce.price }
    item
    invoice
  end
end
