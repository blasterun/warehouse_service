require 'test_helper'

class CustomerCTests < ActiveSupport::TestCase
  setup do
    @pricing_model = FactoryBot.create(
      :pricing_model,
      pricing_strategy: 'per_object_price',
      percentage: 10.0,
      use_persantage: true,
      amount_cents: nil
    )
    @client = FactoryBot.create(:client, pricing_model: @pricing_model)
    FactoryBot.create(:storage_object, client: @client, price_cents: 250_00)
    FactoryBot.create(:storage_object, client: @client, price_cents: 70_00)
    FactoryBot.create(:storage_object, client: @client, price_cents: 20_00)
    @expected_price = (@client.storage_objects.sum(:price_cents) * 10) / 100
  end

  test 'Customer C is to be charged 5% of the value of the item being stored.' do
    summary = InvoiceBuilderService.new(@client).build
    assert_equal summary[:price], @expected_price
  end
end
