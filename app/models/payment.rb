class Payment < ApplicationRecord
  validates :order_id, :status, :payment_gateway, presence: true

  STATUSES = [
    SUCCESS = 'success',
    FAILED = 'failed',
    INITIATED = 'initiated'
  ].freeze

  def self.generate_cod_transaction_id
    loop do
      transaction_id = "cod_#{SecureRandom.hex(3)}"
      break transaction_id unless Payment.where(transaction_id: transaction_id).first
    end
  end
end
