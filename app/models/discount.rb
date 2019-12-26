class Discount < ApplicationRecord
  ATTRIBUTE_MATCHERS = {
    'object_index' => Discount::ObjectIndex,
    'objects_sum' => Discount::ObjectsSum,
    'objects_count' => Discount::ObjectsCount
  }.freeze

  LOGICAL_OPERATOR = '&&'.freeze
  COMPARISON_OPERATORS = ['>', '<', '>=', '<=', '==', '!='].freeze

  has_many :discount_clients
  has_many :clients, through: :discount_clients

  validates :amount_cents, presence: true, if: proc { |c| c.use_persantage == false }
  validates :percentage, presence: true, if: proc { |c| c.use_persantage }
  validates :attribute_matcher, presence: true, inclusion: { in: ATTRIBUTE_MATCHERS.keys }
  validates :operator_from, presence: true, inclusion: { in: COMPARISON_OPERATORS }, allow_nil: true
  validates :operator_to, inclusion: { in: COMPARISON_OPERATORS }, allow_nil: true
  validates :quantity_from, presence: true, if: proc { |c| c.operator_from.present? }
  validates :quantity_to, presence: true, if: proc { |c|
    c.operator_to.present? && c.operator_from.present?
  }

  def calculate_discount(invoice)
    strategy.calculate_discount(invoice)
  end

  def strategy
    @strategy ||= ATTRIBUTE_MATCHERS[attribute_matcher].new(attributes)
  end

  private

  def calculate(price:, condition:, invoice:)
    return price unless match_condition?(condition)

    invoice.discounts |= [id]
    return calculate_persantage(price) if use_persantage

    price - amount_cents
  end

  def calculate_persantage(price)
    price - ((price * percentage.to_f) / 100)
  end

  def match_condition?(value)
    base_chain = [value, operator_from, quantity_from]
    base_chain << [LOGICAL_OPERATOR, value, operator_to, quantity_to] if quantity_to.present?
    eval(base_chain.flatten.join(' '))
  end
end
