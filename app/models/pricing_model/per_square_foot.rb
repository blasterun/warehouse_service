class PricingModel::PerSquareFoot < PricingModel

  def price_required?
    false
  end

  def square_foot_required?
    true
  end

  def calculate(client)
    client.storage_objects.map do |storage_object|
      (storage_object.square_foot_size * percentage.to_f) / 100
    end
  end
end