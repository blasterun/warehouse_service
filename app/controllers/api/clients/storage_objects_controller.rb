module Api
  module Clients
    class StorageObjectsController < BaseClientsController
      before_action :find_client
      before_action :find_storage_objects, except: %i[index create]

      def index
        render json: @client.storage_objects.to_json
      end

      def show
        render json: @storage_objects.to_json
      end

      def create
        storage_object = @client.storage_items.new(storage_object_params)
        if storage_object.save
          render json: storage_object.to_json, status: :created
        else
          render json: storage_object.errors.full_messages, status: :bad_request
        end
      end

      def update
        if @storage_objects.update(storage_object_params)
          render json: @storage_objects.to_json, status: :ok
        else
          render json: @storage_objects.errors.full_messages, status: :bad_request
        end
      end

      def destroy
        if @storage_objects.destroy
          render json: @storage_objects.to_json, status: :ok
        else
          render json: @storage_objects.errors.full_messages, status: :bad_request
        end
      end

      private

      def storage_object_params
        params.require(:storage_object).permit(:name, :price_cents, :square_foot_size)
      end

      def find_storate_item
        @storage_objects = @client.storage_objects.find(params[:id])
      end
    end
  end
end
