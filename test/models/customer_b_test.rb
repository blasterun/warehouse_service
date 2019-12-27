require 'test_helper'

class CustomerBTests < ActiveSupport::TestCase
  setup do
    @pricing_model = FactoryBot.create(:pricing_model, pricing_strategy: 'per_square_foot', amount_cents: 1_00)
    @client = FactoryBot.create(:client, pricing_model: @pricing_model)
    FactoryBot.create(:storage_object, client: @client, square_foot_size: 50)
    FactoryBot.create(:storage_object, client: @client, square_foot_size: 10)
  end

  test 'Customer B stores large items, and will be charged at $1 per square foot.' do
    summary = InvoiceBuilderService.new(@client).build
    assert_equal summary[:price], 60_00
    assert_equal summary[:price], summary[:price_before_discount]
  end
end
