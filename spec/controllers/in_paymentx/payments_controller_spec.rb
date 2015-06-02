require 'rails_helper'

module InPaymentx
  RSpec.describe PaymentsController, type: :controller do
    routes {InPaymentx::Engine.routes}
    before(:each) do
      expect(controller).to receive(:require_employee)
    end
    before(:each) do
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      @project_num_time_gen = FactoryGirl.create(:engine_config, :engine_name => 'fixed_task_projectx', :engine_version => nil, :argument_name => 'project_num_time_gen', 
        :argument_value => ' FixedTaskProjectx::Project.last.nil? ? (Time.now.strftime("%Y%m%d") + "-"  + 112233.to_s + "-" + rand(100..999).to_s) :  (Time.now.strftime("%Y%m%d") + "-"  + (FixedTaskProjectx::Project.last.project_num.split("-")[-2].to_i + 555).to_s + "-" + rand(100..999).to_s)')
      @payment_type = FactoryGirl.create(:engine_config, :engine_name => 'in_paymentx', :engine_version => nil, :argument_name => 'payment_via', :argument_value => 'Cash, Check, Coupon, Credit Card, Credit Letter')
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      @cust = FactoryGirl.create(:kustomerx_customer)
      @proj = FactoryGirl.create(:ext_construction_projectx_project, :customer_id => @cust.id)
      @proj1 = FactoryGirl.create(:ext_construction_projectx_project, :name => 'a new name', :project_num => 'something new') #, :customer_id => @cust.id)
      @contract = FactoryGirl.create(:simple_contractx_contract, :void => false, :last_updated_by_id => @u.id, :project_id => @proj.id)
      @contract1 = FactoryGirl.create(:simple_contractx_contract, :void => false, :last_updated_by_id => @u.id, :project_id => @proj1.id)
      
      session[:user_role_ids] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id).user_role_ids
    end
      
    render_views
    
    describe "GET 'index'" do
      it "returns all payments for regular user" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "InPaymentx::Payment.all.order('created_at')")
        session[:employee] = true
        session[:user_id] = @u.id        
        qs = FactoryGirl.create(:in_paymentx_payment, :last_updated_by_id => @u.id, :project_id => @proj.id)
        qs1 = FactoryGirl.create(:in_paymentx_payment, :last_updated_by_id => @u.id)
        get 'index' 
        expect(assigns(:payments)).to match_array([qs, qs1])       
      end
      
      it "should return payments for the project" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "InPaymentx::Payment.all.order('created_at')")
        session[:employee] = true
        session[:user_id] = @u.id        
        qs = FactoryGirl.create(:in_paymentx_payment,  :last_updated_by_id => @u.id, :project_id => @proj.id)
        qs1 = FactoryGirl.create(:in_paymentx_payment, :last_updated_by_id => @u.id, :project_id => @proj1.id)
        get 'index' , {:project_id => @proj.id}
        expect(assigns(:payments)).to match_array([qs])
      end
    end
  
    describe "GET 'new'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:employee] = true
        session[:user_id] = @u.id      
        get 'new' , {:project_id => @proj.id, :contract_id => @contract.id}
        expect(response).to be_success
      end
      
    end
  
    describe "GET 'create'" do
      it "redirect for a successful creation" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:employee] = true
        session[:user_id] = @u.id        
        qs = FactoryGirl.attributes_for(:in_paymentx_payment, :project_id => @proj.id, :contract_id => @contract.id)
        get 'create' , { :payment => qs, :project_id => @proj.id, :contract_id => @contract.id}
        expect(response).to redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      end
      
      it "should render 'new' if data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:employee] = true
        session[:user_id] = @u.id
        
        qs = FactoryGirl.attributes_for(:in_paymentx_payment, :paid_amount => nil, :contract_id => @contract.id, :project_id => @proj.id)
        get 'create' , {:project_id => @proj.id, :payment => qs, :contract_id => @contract.id}
        expect(response).to render_template("new")
      end
    end
  
    describe "GET 'edit'" do
      
      it "returns http success for edit" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:employee] = true
        session[:user_id] = @u.id        
        qs = FactoryGirl.create(:in_paymentx_payment, :project_id => @proj.id, :contract_id => @contract.id)
        get 'edit' , {:project_id => @proj.id, :id => qs.id, :contract_id => @contract.id}
        expect(response).to be_success
      end
      
    end
  
    describe "GET 'update'" do
      
      it "redirect if success" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:employee] = true
        session[:user_id] = @u.id       
        qs = FactoryGirl.create(:in_paymentx_payment)
        get 'update' , {:project_id => @proj.id, :id => qs.id, :contract_id => @contract.id, :payment => {:payment_via => 'true'}}
        expect(response).to redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      end
      
      it "should render 'new' if data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:employee] = true
        session[:user_id] = @u.id
        
        qs = FactoryGirl.create(:in_paymentx_payment)
        get 'update' , {:project_id => @proj.id, :id => qs.id, :contract_id => @contract.id, :payment => {:paid_amount => nil}}
        expect(response).to render_template("edit")
      end
    end
  
    describe "GET 'show'" do
      
      it "should show" do
        user_access = FactoryGirl.create(:user_access, :action => 'show', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:employee] = true
        session[:user_id] = @u.id        
        qs = FactoryGirl.create(:in_paymentx_payment, :project_id => @proj.id, :contract_id => @contract.id)
        get 'show' , {:id => qs.id}
        expect(response).to be_success
      end
    end
  
  end
end
