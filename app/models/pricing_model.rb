class PricingModel < ApplicationRecord
  PRICING_STRATEGIES = {
    'per_object' => PricingModel::PerObject,
    'per_square_foot' => PricingModel::PerSquareFoot,
    'per_object_price' => PricingModel::PerObjectPrice
  }.freeze

  has_many :clients

  validates :pricing_strategy, presence: true, inclusion: { in: PRICING_STRATEGIES.keys }
  validates :amount_cents, presence: true, if: proc { |c| c.use_persantage == false }
  validates :percentage, presence: true, if: proc { |c| c.use_persantage }

  def calculate(client)
    strategy.calculate(client)
  end

  def strategy
    @strategy ||= PRICING_STRATEGIES[pricing_strategy].find(id)
  end

  def as_json(options = {})
    super({ only: %i[id pricing_strategy amount_cents percentage use_persantage] }.merge(options || {}))
  end
end
