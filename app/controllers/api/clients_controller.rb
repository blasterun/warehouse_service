module Api
  class ClientsController < BaseClientsController
    before_action :find_client, only: %i[show update destroy]

    def index
      render json: Client.all.to_json
    end

    def show
      render json: @client.to_json
    end

    def create
      client = Client.new(client_params)
      if client.save
        render json: client.to_json, status: :created
      else
        render json: client.errors.full_messages, status: :bad_request
      end
    end

    def update
      if @client.update(client_params)
        render json: @client.to_json, status: :ok
      else
        render json: @client.errors.full_messages, status: :bad_request
      end
    end

    def destroy
      if @client.destroy
        render json: @client.to_json, status: :ok
      else
        render json: discount.errors.full_messages, status: :bad_request
      end
    end

    private

    def client_params
      params.require(:client).permit(:name, :pricing_model_id)
    end
  end
end
