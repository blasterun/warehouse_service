class PricingModel < ApplicationRecord
  # pricing not payment
  #methods
  PRICING_STRATEGIES = {
    'per_item' => PricingModel::PerItem,
    'per_square_foot' => PricingModel::PerSquareFoot,
    'per_item_price' => PricingModel::PerItemPrice
  }.freeze

  #AMOUNT_TYPES = %w(percentage money).freeze # cash
  # CURRENCIES = %w(usd).freeze

  has_many :clients

  validates :pricing_strategy, presence: true, inclusion: { in: PRICING_STRATEGIES.keys }
  #validates :amount_cents#, presence: true#, if { strategy.price_required? }
  #validates :percentage#, presence: true #, if { strategy.price_required? }
  # validates :currency, inclusion: { in: CURRENCIES }

  def price_required?
    strategy.price_required?
  end

  def square_foot_required?
    strategy.square_foot_required?
  end

  def calculate(client)
    strategy.calculate(client)
  end

  def strategy
    # return nil unless persisted
    @strategy ||= PRICING_STRATEGIES[pricing_strategy].find(id)
  end
end
