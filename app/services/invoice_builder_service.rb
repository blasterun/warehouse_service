class InvoiceBuilderService
  attr_reader :client, :pricing_model, :discounts, :summary

  def initialize(client)
    @client                 = client
    @pricing_model          = client.pricing_model
    @discounts              = client.discounts
    @summary                = default_summary
  end

  def build
    calculate_pricing_model
    calculate_discounts
    summary[:price] = summary[:price]/100
    summary[:price_after_discounts] = summary[:price_after_discounts]/100
    summary
  end

  private

  def calculate_pricing_model
    summary[:storage_objects]       = pricing_model.calculate(client)
    summary[:price]                 = summary[:storage_objects].sum
    summary[:price_after_discounts] = summary[:price]
  end

  def calculate_discounts
    discounts.each do |discount|
      discount.calculate_discount(summary)
    end
  end

  def default_summary
    {
      price: nil,
      price_after_discounts: nil,
      storage_objects: nil,
      storage_objects_count: nil,
      used_discounts: []
    }
  end
end
