FactoryBot.define do
  factory :invoiceitems do
    quantity { Faker::Number.within(range: 1..50) }
    unit_price { Faker::Commerce.price }
    item
    invoice
  end
end