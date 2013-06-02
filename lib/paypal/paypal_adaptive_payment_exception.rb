class PaypalAdaptivePaymentException < StandardError

  attr_accessor :error

  def initialize(error_obj)
     @error = error_obj
  end


end