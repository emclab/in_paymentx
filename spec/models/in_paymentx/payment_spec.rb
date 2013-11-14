require 'spec_helper'

module InPaymentx
  describe Payment do
    it "should be OK" do
      p = FactoryGirl.build(:in_paymentx_payment)
      p.should be_valid
    end
    
    it "should reject nil pay_amount" do
      p = FactoryGirl.build(:in_paymentx_payment, :paid_amount => nil)
      p.should_not be_valid
    end
    
    it "should take 0 pay amount" do
      p = FactoryGirl.build(:in_paymentx_payment, :paid_amount => 0)
      p.should be_valid
    end
    
    it "should have received date" do
      p = FactoryGirl.build(:in_paymentx_payment, :received_date => nil)
      p.should_not be_valid
    end
    
    it "should have payment via" do
      p = FactoryGirl.build(:in_paymentx_payment, :payment_via => nil)
      p.should_not be_valid
    end
    
    it "should have contract id" do
      p = FactoryGirl.build(:in_paymentx_payment, :contract_id => nil)
      p.should_not be_valid
    end
    
    it "should have 0 contract id" do
      p = FactoryGirl.build(:in_paymentx_payment, :contract_id => 0)
      p.should_not be_valid
    end
    
    it "should have project id" do
      p = FactoryGirl.build(:in_paymentx_payment, :project_id => nil)
      p.should_not be_valid
    end
    
    it "should have 0 project id" do
      p = FactoryGirl.build(:in_paymentx_payment, :project_id => 0)
      p.should_not be_valid
    end
    
  end
end
