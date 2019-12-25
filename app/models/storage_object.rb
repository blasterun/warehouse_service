class StorageObject < ApplicationRecord
  belongs_to :client
  # belongs_to :payment_model, through: :client
  #add currency if price present

  validates :client, presence: true
  validates :price_cents, presence: true, if: proc { |st_obj| st_obj.client.pricing_model.price_required? }
  validates :square_foot_size, presence: true, if: proc { |st_obj| st_obj.client.pricing_model.square_foot_required? }
end
