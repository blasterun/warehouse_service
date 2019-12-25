class StorageObject < ApplicationRecord
  belongs_to :client

  validates :name, :client, :price_cents, :square_foot_size, presence: true
end
