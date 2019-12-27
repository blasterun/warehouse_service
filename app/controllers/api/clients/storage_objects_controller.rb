module Api
  module Clients
    class StorageObjectsController < ApplicationController
      before_action :find_client

      def index
        render json: @client.storage_objects.to_json
      end

      def show
        render json: @client.storage_objects.find(params[:id]).to_json
      end

      def create
        storage_object = StorageObject.new(storage_object)
        if storage_object.save
          render json: storage_object.to_json, status: :created
        else
          render json: storage_object.errors.full_messages, status: :bad_request
        end
      end

      def destroy
        storage_object = @client.discount_clients.find_by(discount_id: params[:id])
        if storage_object.destroy
          render json: { status: :ok }
        else
          render json: storage_object.errors.full_messages, status: :bad_request
        end
      end

      private

      def storage_object_params
        params.require(:storage_object).permit(:discount_id, :client_id)
      end
    end
  end
end
