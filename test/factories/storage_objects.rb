FactoryBot.define do
  factory :storage_object do
    name Faker::House.furniture
    client
    price_cents Faker::Number.number(digits: 4)
    square_foot_size Faker::Number.number(digits: 2)
  end
end
