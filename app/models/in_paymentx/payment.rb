module InPaymentx
  class Payment < ActiveRecord::Base
    default_scope {where(fort_token: RequestStore.store[:current_token])}
    
    attr_accessor :project_name                

    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :contract, :class_name => InPaymentx.contract_class.to_s
    belongs_to :project, :class_name => InPaymentx.project_class.to_s
    belongs_to :received_by, :class_name => 'Authentify::User'
    belongs_to :payer, :class_name => InPaymentx.payer_class.to_s
    belongs_to :bank_acct, :class_name => InPaymentx.bank_acct_class.to_s
    belongs_to :category, :class_name => 'Commonx::MiscDefinition'

    validates :paid_amount, :presence => true,
                            :numericality => {:greater_than_or_equal_to => 0}                            
    validates :received_date, :presence => true
    validates :fort_token, :presence => true
    validates :contract_id, :presence => true, :numericality => {:greater_than => 0, :only_integer => true}, :if => 'contract_id.present?'
    validates :project_id, :numericality => {:greater_than => 0, :only_integer => true}, :if => 'project_id.present?'
    validates :payer_id, :numericality => {:greater_than => 0, :only_integer => true}, :if => 'payer_id.present?'
    validates :category_id, :numericality => {:greater_than => 0, :only_integer => true}, :if => 'category_id.present?'
    validates :bank_acct_id, :numericality => {:greater_than => 0, :only_integer => true}, :if => 'bank_acct_id.present?'
    validate :dynamic_validate 
    
    def dynamic_validate
      wf = Authentify::AuthentifyUtility.find_config_const('dynamic_validate', self.fort_token, 'in_paymentx')
      eval(wf) if wf.present?
    end        
  end
end
