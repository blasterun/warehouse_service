require 'test_helper'

class BonusTests < ActiveSupport::TestCase
  setup do
    @pricing_model = FactoryBot.create(:pricing_model, pricing_strategy: 'per_object')
    @client = FactoryBot.create(:client, pricing_model: @pricing_model)
    20.times do
      FactoryBot.create(:storage_object, client: @client)
    end
    @discount = FactoryBot.create(
      :discount,
      attribute_matcher: 'objects_sum',
      amount_cents: 200_00,
      percentage: nil,
      use_persantage: false,
      operator_from: '>=',
      quantity_from: 400_00
    )
    @client.discounts << @discount
  end

  test 'Flat $200 discount when their monthly bill reaches $400' do
    summary = InvoiceBuilderService.new(@client).build

    assert_equal 400_00, summary[:price_before_discount]
    assert_equal 200_00, summary[:price]
  end
end
