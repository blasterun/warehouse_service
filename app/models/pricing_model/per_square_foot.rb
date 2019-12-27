class PricingModel
  class PerSquareFoot < PricingModel
    def calculate(client)
      client.storage_objects.map do |storage_object|
        storage_object.square_foot_size * amount_cents
      end
    end
  end
end
