class StorageObject < ApplicationRecord
  belongs_to :client

  validates :name, :client, :price_cents, :square_foot_size, presence: true

  def as_json(options = {})
    super({ only: %i[id name price_cents square_foot_size] }.merge(options || {}))
  end
end
