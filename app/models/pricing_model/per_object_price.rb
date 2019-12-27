class PricingModel
  class PerObjectPrice < PricingModel
    def calculate(client)
      client.storage_objects.map do |storage_object|
        (storage_object.price_cents * percentage.to_f) / 100
      end
    end
  end
end
