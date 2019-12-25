module Api
  class PricingModelsController < ApplicationController
    def index
      render json: PricingModel.all.to_json(only: [:id, :pricing_type, :amount, :amount_type])
    end
  end
end
