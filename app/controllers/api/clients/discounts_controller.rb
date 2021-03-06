module Api
  module Clients
    class DiscountsController < Api::BaseClientsController
      before_action :find_client

      def index
        render json: @client.discounts.to_json
      end

      def create
        discount = @client.discount_clients.new(discount_client_params)
        if discount.save
          render json: discount.to_json, status: :created
        else
          render json: discount.errors.full_messages, status: :bad_request
        end
      end

      def destroy
        discount = @client.discount_clients.find_by(discount_id: params[:id])
        if discount.destroy
          render json: discount.to_json, status: :ok
        else
          render json: discount.errors.full_messages, status: :bad_request
        end
      end

      private

      def discount_client_params
        params.require(:discount_client).permit(:discount_id)
      end
    end
  end
end
