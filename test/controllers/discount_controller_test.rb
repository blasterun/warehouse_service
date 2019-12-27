require 'test_helper'

class DiscountControllerTest < ActionDispatch::IntegrationTest
  setup do
    @discount                    = FactoryBot.create(:discount)
    @discount_json               = @discount.as_json.stringify_keys
    @discount_json['percentage'] = @discount_json['percentage'].to_s # as Numeric not matching
    @valid_params                = FactoryBot.build(:discount).as_json(root: true)
    @not_valid_params            = FactoryBot.build(:discount_not_valid).as_json(root: true)
  end

  test 'Get all discounts' do
    get api_discounts_path
    assert_equal([@discount_json], response.parsed_body)
  end

  test 'Get single discount' do
    get api_discount_path(@discount)
    assert_equal(@discount_json, response.parsed_body)
  end

  test 'Create discount' do
    assert_difference('Discount.count') do
      post api_discounts_path, params: @valid_params
    end
    assert_response :created
  end

  test 'Unable to create not valid discount' do
    assert_no_difference('Discount.count') do
      post api_discounts_path, params: @not_valid_params
    end
    assert_response :bad_request
  end

  test 'Update discount' do
    update_attributes = @discount.as_json(root: true)
    update_attributes['discount']['percentage'] = '20.0'
    patch api_discount_path(@discount), params: update_attributes
    assert_equal(update_attributes['discount'], response.parsed_body)
    assert_not_equal(@discount.attributes, response.parsed_body)
    assert_response :ok
  end

  test 'Destroy discount' do
    delete api_discount_path(@discount)
    assert_raises ActiveRecord::RecordNotFound do
      @discount.reload
    end
    assert_response :ok
  end
end
