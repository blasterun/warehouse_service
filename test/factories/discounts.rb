FactoryBot.define do
  factory :discount do
    discounting_strategy "MyString"
    amount_cents 1
    percentage "9.99"
    quantity_from 1
    quantity_to 1
    use_persantage false
  end
end
