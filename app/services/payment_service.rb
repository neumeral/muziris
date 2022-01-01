class PaymentService
  def initialize; end

  def payment_service(params)
    PaymentMethod.active_provider.classify.constantize.new(params)
   end
end
