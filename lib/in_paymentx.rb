require "in_paymentx/engine"

module InPaymentx
  mattr_accessor :contract_class, :project_class, :show_contract_path, :contract_resource
  
  def self.contract_class
    @@contract_class.constantize
  end
  
  def self.project_class
    @@project_class.constantize
  end
end
