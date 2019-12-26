require 'test_helper'

class CustomerATests < ActiveSupport::TestCase
  setup do
    @pricing_model = FactoryBot.create(:pricing_model, pricing_strategy: 'per_object')
    @client = FactoryBot.create(:client, pricing_model: @pricing_model)
    @storage_object = FactoryBot.create(:storage_object, client: @client)
    @discount = FactoryBot.create(:discount, attribute_matcher: 'objects_sum')
    @client.discounts << @discount
    @ten_persent_of_fee_cost = @pricing_model.amount_cents * 10 / 100
  end

  test 'Customer A receive a 10% discount' do
    summary = InvoiceBuilderService.new(@client).build
    assert_operator summary[:price_before_discount], :>=, summary[:price]
    assert_equal summary[:price_before_discount] - @ten_persent_of_fee_cost, summary[:price]
  end
end
