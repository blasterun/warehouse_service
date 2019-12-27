class DiscountClient < ApplicationRecord
  belongs_to :discount
  belongs_to :client

  validates :client_id, presence: true, uniqueness: { scope: :discount_id }
  validates :discount_id, presence: true, uniqueness: { scope: :client_id }
end
