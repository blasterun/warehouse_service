class Discount
  class ObjectIndex < Discount
    def calculate_discount(invoice)
      invoice.priced_objects = invoice.priced_objects.map.with_index do |item, index|
        calculate(price: item, condition: index, invoice: invoice)
      end
      invoice.price = invoice.priced_objects.sum
    end
  end
end
