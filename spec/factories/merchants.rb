FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }
  end

  trait :with_items do
    after :create do |merchant|
      create_list(:item, 5)
    end
  end
end
