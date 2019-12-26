FactoryBot.define do
  factory :client do
    name Faker::Name.name
    pricing_model
  end
end
