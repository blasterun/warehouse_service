require 'test_helper'

class CustomerATests < ActiveSupport::TestCase
  setup do
    @pricing_model = FactoryBot.create(:pricing_model, pricing_strategy: 'per_object')
    @client = FactoryBot.create(:client, pricing_model: @pricing_model)
    FactoryBot.create(:storage_object, client: @client)
    @discount = FactoryBot.create(:discount, attribute_matcher: 'objects_sum')
    @client.discounts << @discount
    @expected_discount_in_cash = @pricing_model.amount_cents * 10 / 100
  end

  test 'Customer A will receive a 10% discount.' do
    summary = InvoiceBuilderService.new(@client).build
    assert_operator summary[:price_before_discount], :>=, summary[:price]
    assert_equal summary[:price_before_discount] - @expected_discount_in_cash, summary[:price]
    assert_equal summary[:discounts], [@discount.id]
  end
end
