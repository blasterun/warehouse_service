module Api
  class DiscountsController < ApplicationController
    def index
      render json: Discount.all.to_json
    end

    def show
    end

    def create
      discount = Discount.new(discount_params)
      if discount.save
        render json: discount.to_json, status: :created
      else
        render json: discount.errors.full_messages, status: :bad_request
      end
    end

    def discount_params
      params.require(:discount).permit(
        :attribute_matcher, :amount_cents, :percentage, :use_persantage,
        :operator_from, :operator_to, :quantity_from, :quantity_to
      )
    end
  end
end
