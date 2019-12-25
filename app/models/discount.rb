class Discount < ApplicationRecord
  has_many :discount_clients
  has_many :clients, through: :discount_clients

  LOGICAL_OPERATOR = "&&".freeze
  COMPARISON_OPERATORS = ['>', '<', '>=', '<=', '==', '!='].freeze
  ATTRIBUTE_MATCHERS = %w(object_index total_sum).freeze

  def calculate_discount(prices_model_summary)
    raise NotImplementedError if ATTRIBUTE_MATCHERS.exclude?(attribute_matcher)
    if attribute_matcher == 'object_index'
      prices_model_summary[:storage_objects] = prices_model_summary[:storage_objects].map.with_index do|item, index|
        calculate(item, index)
      end
      prices_model_summary[:price_after_discounts] = prices_model_summary[:storage_objects].sum
    elsif attribute_matcher == 'total_sum'
      calculate(prices_model_summary[:price_after_discounts], prices_model_summary[:price_after_discounts])
    end
  end

  private

  def calculate(price, value)
    return price unless match_condition?(value)
    return calculate_persantage(price) if use_persantage
    price - amount_cents
  end

  def calculate_persantage(price)
    price - ((price * percentage.to_f) / 100)
  end

  def match_condition?(value)
    base_chain = [value, operator_from , quantity_from]
    base_chain << [LOGICAL_OPERATOR, value, operator_to , quantity_to] if operator_to.present?
    eval(base_chain.flatten.join(' '))
  end
end
