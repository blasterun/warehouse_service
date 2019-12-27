module Api
  module Clients
    class InvoicesController < BaseClientsController
      before_action :find_client

      def index
        render json: InvoiceBuilderService.new(@client).build
      end
    end
  end
end
