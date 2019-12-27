module Api
  class BaseClientsController < ApplicationController
    private

    def find_client
      id = controller_name == 'clients' ? params[:id] : params[:client_id]
      @client = Client.find(id)
    end
  end
end
