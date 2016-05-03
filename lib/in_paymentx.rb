require "in_paymentx/engine"

module InPaymentx
  mattr_accessor :contract_class, :project_class, :payer_class
  
  def self.contract_class
    @@contract_class.constantize
  end
  
  def self.project_class
    @@project_class.constantize
  end
  
  def self.payer_class
    @@payer_class.constantize
  end
  
end
