require 'test_helper'

class PricingModelControllerTest < ActionDispatch::IntegrationTest
  test 'Get all Pricing Models' do
    pricing_model = FactoryBot.create(:pricing_model)
    get api_pricing_models_path
    assert_equal([pricing_model.as_json.stringify_keys], response.parsed_body)
  end

  test 'Create Pricing Model' do
    pricing_model_attributes = FactoryBot.build(:pricing_model).as_json(root: true)
    assert_difference('PricingModel.count') do
      post api_pricing_models_path, params: pricing_model_attributes
    end
    assert_response :created
  end

  test 'Unable to create not valid Pricing Model' do
    pricing_model_attributes = FactoryBot.build(:pricing_model).as_json(root: true)
    pricing_model_attributes['pricing_model'].delete('pricing_strategy')
    assert_no_difference('PricingModel.count') do
      post api_pricing_models_path, params: pricing_model_attributes
    end
    assert_response :bad_request
  end
end
