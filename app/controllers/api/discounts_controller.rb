module Api
  class DiscountsController < ApplicationController
    before_action :find_discount, only: %i[show update destroy]

    def index
      render json: Discount.all.to_json
    end

    def show
      render json: @discount.to_json
    end

    def create
      discount = Discount.new(discount_params)
      if discount.save
        render json: discount.to_json, status: :created
      else
        render json: discount.errors.full_messages, status: :bad_request
      end
    end

    def update
      if @discount.update(discount_params)
        render json: @discount.to_json, status: :ok
      else
        render json: @discount.errors.full_messages, status: :bad_request
      end
    end

    def destroy
      if @discount.destroy
        render json: @discount.to_json, status: :ok
      else
        render json: @discount.errors.full_messages, status: :bad_request
      end
    end

    private

    def discount_params
      params.require(:discount).permit(
        :attribute_matcher, :amount_cents, :percentage, :use_persantage,
        :operator_from, :operator_to, :quantity_from, :quantity_to
      )
    end

    def find_discount
      @discount = Discount.find(params[:id])
    end
  end
end
