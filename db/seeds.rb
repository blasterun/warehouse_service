require 'faker'

pm = PricingModel.new(pricing_strategy: :per_object, amount_cents: 20_00)
pm.save!
client = Client.new(pricing_model: pm, name: Faker::Name.name)
client.save!
250.times do
  st = StorageObject.new(
    client: client,
    name: Faker::House.furniture,
    price_cents: Faker::Number.number(digits: 4),
    square_foot_size: Faker::Number.number(digits: 2)
  )
  st.save!
end

discount = Discount.new(
  attribute_matcher: 'object_index',
  percentage: 5,
  use_persantage: true,
  operator_from: '>=',
  operator_to: '<=',
  quantity_from: 0,
  quantity_to: 99
)
discount.save
discount2 = Discount.new(
  attribute_matcher: 'object_index',
  percentage: 10,
  use_persantage: true,
  operator_from: '>=',
  operator_to: '<=',
  quantity_from: 100,
  quantity_to: 200
)
discount2.save
discount3 = Discount.new(
  attribute_matcher: 'object_index',
  percentage: 15,
  use_persantage: true,
  operator_from: '>',
  quantity_from: 200,
)
discount3.save
client.discounts << [discount, discount2, discount3]
