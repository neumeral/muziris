class TaxRate < ApplicationRecord
  validates :name, presence: true
  validates :rate, presence: true
end
