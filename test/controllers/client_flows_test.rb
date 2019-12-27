require 'test_helper'

class ClientFlowTest < ActionDispatch::IntegrationTest
  setup do
    @pricing_model    = FactoryBot.create(:pricing_model, pricing_strategy: 'per_object')
    @client           = FactoryBot.create(:client, pricing_model: @pricing_model)
    @storage_object   = FactoryBot.create(:storage_object, client: @client)
    @discount         = FactoryBot.create(:discount, attribute_matcher: 'objects_sum')
    @client.discounts << @discount
    @s_o_json = @storage_object.as_json(root: true)
    @s_o_json['storage_object']['square_foot_size'] = @s_o_json['storage_object']['square_foot_size'].to_s
  end

  #### Invoice ######
  test 'Client have invoice information' do
    get api_client_invoices_path(@client)
    summary = InvoiceBuilderService.new(@client).build
    assert_equal(summary.stringify_keys, response.parsed_body)
  end

  #### Storage Object ######
  test 'Client all storage_object' do
    get api_client_storage_objects_path(@client)
    assert_equal([@s_o_json['storage_object']], response.parsed_body)
  end

  test 'Client single storage_object' do
    get api_client_storage_object_path(@client, @storage_object)
    assert_equal(@s_o_json['storage_object'], response.parsed_body)
  end

  test 'Create storage_object' do
    assert_difference('StorageObject.count') do
      post api_client_storage_objects_path(@client), params: FactoryBot.build(:storage_object).as_json(root: true)
    end
    assert_response :created
  end

  test 'Update distorage_objectscount' do
    attributes = @storage_object.as_json(root: true)
    attributes['storage_object']['name'] = 'TestCase'
    attributes['storage_object']['square_foot_size'] = attributes['storage_object']['square_foot_size'].to_s
    patch api_client_storage_object_path(@client, @storage_object), params: attributes
    assert_equal(attributes['storage_object'], response.parsed_body)
    assert_not_equal(@s_o_json, response.parsed_body)
    assert_response :ok
  end

  test 'Destroy storage_object' do
    delete api_client_storage_object_path(@client, @storage_object)
    assert_raises ActiveRecord::RecordNotFound do
      @storage_object.reload
    end
    assert_response :ok
  end

  #### Discounts ######
  test 'Client have discounts' do
    get api_client_discounts_path(@client)
    assert_equal(@discount.as_json.except('percentage'), response.parsed_body[0].except('percentage'))
    assert_equal(1, response.parsed_body.size)
  end

  test 'Discount can be assigned to client' do
    discount = FactoryBot.create(:first_100_objects_5_persent_discount)
    assert_difference('DiscountClient.count') do
      post api_client_discounts_path(@client), params: { discount_client: { discount_id: discount.id } }
    end
    assert_equal(2, @client.discounts.count)
  end

  test 'Discount can be removed from client' do
    discount_client = @client.discount_clients.find_by(discount_id: @discount.id)
    delete api_client_discount_path(@client, @discount)
    assert_raises ActiveRecord::RecordNotFound do
      discount_client.reload
    end
    assert_equal(0, @client.discounts.count)
  end
end
