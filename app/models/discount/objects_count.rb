class Discount
  class ObjectsCount < Discount
    def calculate_discount(invoice)
      invoice.price = calculate(price: invoice.price, condition: invoice.priced_objects.count, invoice: invoice)
    end
  end
end
