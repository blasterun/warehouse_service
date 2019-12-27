module Api
  class ClientsController < BaseClientsController
    before_action :find_client

    def index
      render json: Client.all.to_json
    end

    def show
      @client = Client.find(params[:id])
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
      client = Client.new(client_params)
      if client.save
        render json: client.to_json, status: :ok
      else
        render json: client.errors.full_messages, status: :bad_request
      end
    end

    def client_params
      params.require(:client).permit(:name, :pricing_model_id)
    end
  end
end
