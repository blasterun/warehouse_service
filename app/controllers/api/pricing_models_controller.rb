module Api
  class PricingModelsController < ApplicationController
    #before_action :find_pricing_model, except: [:index]

    def index
      render json: PricingModel.all.to_json
    end

    def create
      pricing_model = PricingModel.new(pricing_model_params)
      if pricing_model.save
        render json: pricing_model.to_json, status: :created
      else
        render json: pricing_model.errors.full_messages, status: :bad_request
      end
    end

    # def find_pricing_model
    #   @contact = Contact.with_deleted.find(params[:id])
    # end

    def pricing_model_params
      params.require(:pricing_model).permit(
        :pricing_strategy, :amount_cents, :percentage, :use_persantage
      )
    end
  end
end
