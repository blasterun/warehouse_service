require 'test_helper'

class PricingModelControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pricing_model = FactoryBot.create(:pricing_model)
    @pricing_model_json = @pricing_model.as_json.stringify_keys
    @valid_params = FactoryBot.build(:pricing_model).as_json(root: true)
    @not_valid_params = FactoryBot.build(:pricing_model_not_valid).as_json(root: true)
  end

  test 'Get all Pricing Models' do
    get api_pricing_models_path
    assert_equal([@pricing_model_json], response.parsed_body)
  end

  test 'Get single Pricing Models' do
    get api_pricing_model_path(@pricing_model)
    assert_equal(@pricing_model_json, response.parsed_body)
  end

  test 'Create Pricing Model' do
    assert_difference('PricingModel.count') do
      post api_pricing_models_path, params: @valid_params
    end
    assert_response :created
  end

  test 'Unable to create not valid Pricing Model' do
    assert_no_difference('PricingModel.count') do
      post api_pricing_models_path, params: @not_valid_params
    end
    assert_response :bad_request
  end

  test 'Update Pricing Model' do
    update_attributes = @pricing_model.as_json(root: true)
    update_attributes['pricing_model']['amount_cents'] = 40_00
    patch api_pricing_model_path(@pricing_model), params: update_attributes
    assert_equal(update_attributes['pricing_model'], response.parsed_body)
    assert_not_equal(@pricing_model.attributes, response.parsed_body)
    assert_response :ok
  end

  test 'Destroy Pricing Model' do
    delete api_pricing_model_path(@pricing_model)
    assert_raises ActiveRecord::RecordNotFound do
      @pricing_model.reload
    end
    assert_response :ok
  end
end
