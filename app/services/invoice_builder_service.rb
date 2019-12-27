class InvoiceBuilderService
  attr_reader :client
  attr_accessor :priced_objects, :price_before_discount, :price, :discounts

  def initialize(client)
    @client                 = client
    @priced_objects         = nil
    @price_before_discount  = nil
    @price                  = nil
    @discounts              = []
  end

  def build
    calculate_pricing_model
    calculate_discounts
    summary
  end

  private

  def calculate_pricing_model
    self.priced_objects                 = client.pricing_model.calculate(client)
    self.price_before_discount          = priced_objects.sum
    self.price                          = price_before_discount
  end

  def calculate_discounts
    client.discounts.each do |discount|
      discount.calculate_discount(self)
    end
  end

  def summary
    {
      price_before_discount: price_before_discount,
      price: price.to_i,
      discounts: discounts,
      priced_objects: priced_objects
    }
  end
end
