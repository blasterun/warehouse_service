class DiscountClient < ApplicationRecord
  belongs_to :discount
  belongs_to :client
end
