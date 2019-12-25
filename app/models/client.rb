class Client < ApplicationRecord
  belongs_to :pricing_model
  has_many :storage_objects
  has_many :discount_clients
  has_many :discounts, throught: :discount_clients

  validates :pricing_model, :name, presence: true
end
