class Discount
  class ObjectsSum < Discount
    def calculate_discount(invoice)
      calculate(price: invoice.price, condition: invoice.price, invoice: invoice)
    end
  end
end
