class PricingModel::PerObject < PricingModel

  def calculate(client)
    client.storage_objects.count.times.map { |s| amount_cents }
  end
end
