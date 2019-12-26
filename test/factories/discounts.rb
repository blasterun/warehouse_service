FactoryBot.define do
  factory :discount do
    attribute_matcher "objects_sum"
    amount_cents nil
    percentage 10.0
    operator_from nil
    operator_to nil
    quantity_from nil
    quantity_to nil
    use_persantage true
  end
end
