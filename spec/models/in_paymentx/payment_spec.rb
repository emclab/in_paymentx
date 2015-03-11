require 'rails_helper'

module InPaymentx
  RSpec.describe Payment, type: :model do
    it "should be OK" do
      p = FactoryGirl.build(:in_paymentx_payment)
      expect(p).to be_valid
    end
    
    it "should reject nil pay_amount" do
      p = FactoryGirl.build(:in_paymentx_payment, :paid_amount => nil)
      expect(p).not_to be_valid
    end
    
    it "should take 0 pay amount" do
      p = FactoryGirl.build(:in_paymentx_payment, :paid_amount => 0)
      expect(p).to be_valid
    end
    
    it "should have received date" do
      p = FactoryGirl.build(:in_paymentx_payment, :received_date => nil)
      expect(p).not_to be_valid
    end
    
    it "should have payment via" do
      p = FactoryGirl.build(:in_paymentx_payment, :payment_via => nil)
      expect(p).not_to be_valid
    end
    
    it "should have contract id" do
      p = FactoryGirl.build(:in_paymentx_payment, :contract_id => nil)
      expect(p).not_to be_valid
    end
    
    it "should have 0 contract id" do
      p = FactoryGirl.build(:in_paymentx_payment, :contract_id => 0)
      expect(p).not_to be_valid
    end
    
    it "should have project id" do
      p = FactoryGirl.build(:in_paymentx_payment, :project_id => nil)
      expect(p).to be_valid
    end
    
    it "should not have 0 project id" do
      p = FactoryGirl.build(:in_paymentx_payment, :project_id => 0)
      expect(p).not_to be_valid
    end
    
  end
end
