module Api
  class PricingModelsController < ApplicationController
    before_action :find_pricing_model, only: %i[show update destroy]

    def index
      render json: PricingModel.all.to_json
    end

    def show
      render json: @pricing_model.to_json
    end

    def create
      pricing_model = PricingModel.new(pricing_model_params)
      if pricing_model.save
        render json: pricing_model.to_json, status: :created
      else
        render json: pricing_model.errors.full_messages, status: :bad_request
      end
    end

    def update
      if @pricing_model.update(pricing_model_params)
        render json: @pricing_model.to_json, status: :ok
      else
        render json: @pricing_model.errors.full_messages, status: :bad_request
      end
    end

    def destroy
      if @pricing_model.destroy
        render json: @pricing_model.to_json, status: :ok
      else
        render json: @pricing_model.errors.full_messages, status: :bad_request
      end
    end

    private

    def pricing_model_params
      params.require(:pricing_model).permit(
        :pricing_strategy, :amount_cents, :percentage, :use_persantage
      )
    end

    def find_pricing_model
      @pricing_model = PricingModel.find(params[:id])
    end
  end
end
