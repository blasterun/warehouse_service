class PricingModel::PerObjectPrice < PricingModel

  def price_required?
    true
  end

  def square_foot_required?
    false
  end

  def calculate(client)
    client.storage_objects.map do |storage_object|
      storage_object.sum(:price) * amount_cents
    end
  end
end
