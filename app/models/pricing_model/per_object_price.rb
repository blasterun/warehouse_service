class PricingModel
  class PerObjectPrice < PricingModel
    def calculate(client)
      client.storage_objects.map do |storage_object|
        storage_object.sum(:price) * amount_cents
      end
    end
  end
end
