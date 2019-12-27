FactoryBot.define do
  factory :pricing_model do
    pricing_strategy "per_object"
    amount_cents 20_00
    percentage nil
    use_persantage false

    factory :pricing_model_not_valid do
      pricing_strategy nil
    end
  end
end
