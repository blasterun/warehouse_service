require 'test_helper'

class ClientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client                    = FactoryBot.create(:client)
    @client_json               = @client.as_json.stringify_keys
    @valid_params              = FactoryBot.build(:client).as_json(root: true)
    @not_valid_params          = FactoryBot.build(:client_not_valid).as_json(root: true)
  end

  test 'Get all clients' do
    get api_clients_path
    assert_equal([@client_json], response.parsed_body)
  end

  test 'Get single client' do
    get api_client_path(@client)
    assert_equal(@client_json, response.parsed_body)
  end

  test 'Create client' do
    assert_difference('Client.count') do
      post api_clients_path, params: @valid_params
    end
    assert_response :created
  end

  test 'Unable to create not valid client' do
    assert_no_difference('Client.count') do
      post api_clients_path, params: @not_valid_params
    end
    assert_response :bad_request
  end

  test 'Update discount' do
    update_attributes = @client.as_json(root: true)
    update_attributes['client']['name'] = 'Andriy'
    patch api_client_path(@client), params: update_attributes
    assert_equal(update_attributes['client'], response.parsed_body)
    assert_not_equal(@client.attributes, response.parsed_body)
    assert_response :ok
  end

  test 'Destroy client' do
    delete api_client_path(@client)
    assert_raises ActiveRecord::RecordNotFound do
      @client.reload
    end
    assert_response :ok
  end
end
