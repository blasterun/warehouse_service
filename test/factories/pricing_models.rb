FactoryBot.define do
  factory :pricing_model do
    pricing_strategy "per_object"
    amount_cents 20_00
    percentage nil
    use_persantage false
  end
end
