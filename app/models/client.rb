class Client < ApplicationRecord
  belongs_to :pricing_model
  has_many :storage_objects, dependent: :destroy
  has_many :discount_clients, dependent: :destroy
  has_many :discounts, through: :discount_clients

  validates :pricing_model, :name, presence: true

  def as_json(options={})
    super({ only: %i[id pricing_model name] }.merge(options || {}))
  end
end
