module Api
  module Clients
    class InvoicesController < ApplicationController
      def index
        @client = Client.find(params[:client_id])
        render json: InvoiceBuilderService.new(@client).build
      end
    end
  end
end
