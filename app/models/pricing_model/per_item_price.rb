class PricingModel::PerItemPrice < PricingModel

  def price_required?
    true
  end

  def square_foot_required?
    false
  end

  def calculate(client)
    object_calculated = client.storage_objects.map do |storage_object|
      storage_object.sum(:price) * amount_cents
    end
    sum = object_calculated.sum
    {
      original_price: sum,
      price_after_discounts: sum,
      storage_objects: object_calculated,
      storage_objects_count: object_calculated.size,
      used_discounts: []
    }
  end
end
#discount here