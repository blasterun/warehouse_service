require 'test_helper'

# Client D would like a 5% discount for the first 100 items stored, 10% discount
# for the next 100, and 15% when they store over 200 items, and be charged at $2 per square foot.

class CustomerDTests < ActiveSupport::TestCase
  setup do
    @pricing_model = FactoryBot.create(:pricing_model)
    @client = FactoryBot.create(:client, pricing_model: @pricing_model)
    250.times { FactoryBot.create(:storage_object, client: @client) }
    @discount1 = FactoryBot.create(:first_100_objects_5_persent_discount)
    @discount2 = FactoryBot.create(:second_100_objects_10_persent_discount)
    @discount3 = FactoryBot.create(:more_then_200_objects_15_persent_discount)
    @client.discounts << [@discount1, @discount2, @discount3]
  end

  test 'Customer D have few dynamic discounts' do
    summary = InvoiceBuilderService.new(@client).build

    assert_not_equal summary[:price_before_discount], summary[:price]
    assert_equal summary[:price_before_discount], 250 * @pricing_model.amount_cents
    assert_equal summary[:discounts], [@discount1.id, @discount2.id, @discount3.id]
    assert_operator summary[:price_before_discount], :>=, summary[:price]

    discount_for_first100_in_cash = ((@pricing_model.amount_cents * 100) * 5) / 100
    price_with_discount_first100 = (100 * @pricing_model.amount_cents) - discount_for_first100_in_cash
    assert_equal summary[:priced_objects][0..99].sum, price_with_discount_first100

    discount_for_second100_in_cash = ((@pricing_model.amount_cents * 100) * 10) / 100
    price_with_discount_second100 = (100 * @pricing_model.amount_cents) - discount_for_second100_in_cash
    assert_equal summary[:priced_objects][100..199].sum, price_with_discount_second100

    discount_for_more_than200_in_cash = ((@pricing_model.amount_cents * 50) * 15) / 100
    price_with_discount_for_more_than200 = (50 * @pricing_model.amount_cents) - discount_for_more_than200_in_cash
    assert_equal summary[:priced_objects][200..249].sum, price_with_discount_for_more_than200
  end
end
