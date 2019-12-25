class PricingModel::PerItem < PricingModel

  def price_required?
    false
  end

  def square_foot_required?
    false
  end

  def calculate(client)
    Rational(client.storage_objects.count * amount_cents, 100).numerator
  end
end