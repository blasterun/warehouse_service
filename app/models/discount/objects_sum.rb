class Discount
  class ObjectsSum < Discount
    def calculate_discount(invoice)
      invoice.price = calculate(price: invoice.price, condition: invoice.price, invoice: invoice)
    end
  end
end
