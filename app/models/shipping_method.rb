class ShippingMethod < ApplicationRecord
  validates :name, :code, :value, :value_type, presence: true
end
