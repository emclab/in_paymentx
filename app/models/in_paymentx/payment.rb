module InPaymentx
  class Payment < ActiveRecord::Base
    attr_accessor :project_name
    attr_accessible :paid_amount, :received_by_id, :brief_note, :received_date, :payment_via, :contract_id, :project_id, 
                    :last_updated_by_id, 
                    :project_name, 
                    :as => :role_new

    attr_accessible :paid_amount, :received_by_id, :brief_note, :received_date, :payment_via, :contract_id, :project_id,
                    :last_updated_by_id,  
                    :project_name, 
                    :as => :role_update

    attr_accessor :project_id_s, :keyword_s, :start_date_s, :end_date_s, :customer_id_s, :payment_via_s,
                    :sales_id_s, :time_frame_s, :received_by_id_s, :zone_id_s

    attr_accessible :project_id_s, :keyword_s, :start_date_s, :end_date_s, :customer_id_s, :payment_via_s,
                    :sales_id_s, :time_frame_s, :received_by_id_s, :zone_id_s,
                    :as => :role_search_stats 
                    

    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :contract, :class_name => InPaymentx.contract_class.to_s
    belongs_to :project, :class_name => InPaymentx.project_class.to_s
    belongs_to :received_by, :class_name => 'Authentify::User'

    validates :paid_amount, :presence => true,
                            :numericality => {:greater_than_or_equal_to => 0}                            
    validates :received_by_id, :received_date, :payment_via, :presence => true
    validates :contract_id, :presence => true, :numericality => {:greater_than => 0}
    validates :project_id, :numericality => {:greater_than => 0}, :if => 'project_id.present?'
    validate :dynamic_validate 
    
    def dynamic_validate
      wf = Authentify::AuthentifyUtility.find_config_const('dynamic_validate', 'in_paymentx')
      eval(wf) if wf.present?
    end        
  end
end
