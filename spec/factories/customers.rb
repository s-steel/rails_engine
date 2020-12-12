FactoryBot.define do
  factory :customer do
    first_name { Faker::Books::Dune.title }
    last_name { Faker::Books::Dune.planet }
  end
end
