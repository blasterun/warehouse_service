class Discount < ApplicationRecord
  has_many :discount_clients
  has_many :clients, throught: :discount_clients

  LOGICAL_OPERATOR = "&&"
  STRATEGIES = %w(fixed logical)
  COMPARISON_OPERATORS = ['>', '<', '>=', '<=', '==', '!=']
  ATTRIBUTE_MATCHERS = %w(object_index total_sum)

  def calculate(prices_model_result)
    if attribute_matcher == 'object_index'
      price_model_result[:storage_objects] = price_model_result[:storage_objects].map.with_index do|item, index|
        calculate(item, index)
      end
      price_model_result[:price_after_discounts] = price_model_result[:storage_objects].sum
    elsif attribute_matcher == 'total_sum'
      price_model[:price_after_discounts] = calculate(price_model[:price_after_discounts], price_model[:price_after_discounts])
    else
      raise NotImplementedError
    end
    price_model
  end

  private

  def calculate(price, value)
    return price unless match_condition?(value)
    return calculate_persantage(price) if use_persantage
    price - amount_cents
  end

  def calculate_persantage(price)
    price - ((price * percentage) / 100)
  end

  def match_condition?(price, value)
    base_chain = [value, operator_from , quantity_from]
    base_chain << [LOGICAL_OPERATOR, value, operator_to , quantity_to] if operator_to.present?
    eval(base_chain.flatten.join(' '))
  end
end

# Discount.new(
#   compare_strategy: 'range',
#   attribute_matcher: 'object_index',
#   percentage: 5,
#   quantity_from: 0,
#   quantity_to: 99,
#   use_persantage: true
# )
# Discount.new(
#   compare_strategy: 'range',
#   attribute_matcher: 'object_index',
#   percentage: 10,
#   quantity_from: 100,
#   quantity_to: 200,
#   use_persantage: true
# )
# Discount.new(
#   compare_strategy: 'logical',
#   attribute_matcher: 'object_index',
#   percentage: 15,
#   operator_from: '>'
#   quantity_from: 200,
#   use_persantage: true
# )
