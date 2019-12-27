FactoryBot.define do
  factory :client do
    name Faker::Name.name
    pricing_model
    factory :client_not_valid do
      name nil
    end
  end
end
