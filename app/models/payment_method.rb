# frozen_string_literal: true

class PaymentMethod < ApplicationRecord
  validates :name, :provider, presence: true

  def self.active_provider
    payment_method = PaymentMethod.where(active: true).order('updated_at').last
    payment_method.provider
  end
end
