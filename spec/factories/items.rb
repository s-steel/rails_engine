FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Beer.name }
    unit_price { Faker::Commerce.price }
    merchant
  end
end
