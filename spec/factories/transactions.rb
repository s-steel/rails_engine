FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Number.number(digits: 16) }
    cerdit_card_expiration_date { '4/23' }
    result { 'success' }
    invoice
  end
end