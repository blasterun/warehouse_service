class PricingModel
  class PerObject < PricingModel
    def calculate(client)
      client.storage_objects.count.times.map { amount_cents }
    end
  end
end
