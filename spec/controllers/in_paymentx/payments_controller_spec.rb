require 'spec_helper'

module InPaymentx
  describe PaymentsController do
    before(:each) do
      controller.should_receive(:require_signin)
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
      @proj_type = FactoryGirl.create(:simple_typex_type)
      @proj_type1 = FactoryGirl.create(:simple_typex_type, :name => 'newnew')
      @tt = FactoryGirl.create(:task_templatex_template, :active => true, :last_updated_by_id => @u.id, :type_id => @proj_type.id)
      @tt1 = FactoryGirl.create(:task_templatex_template, :name => 'a new name', :active => true, :last_updated_by_id => @u.id, :type_id => @proj_type1.id)
      @cust = FactoryGirl.create(:kustomerx_customer)
      @proj = FactoryGirl.create(:fixed_task_projectx_project, :task_template_id => @tt.id, :customer_id => @cust.id)
      @proj1 = FactoryGirl.create(:fixed_task_projectx_project, :task_template_id => @tt1.id, :name => 'a new name', :project_num => 'something new') #, :customer_id => @cust.id)
      @contract = FactoryGirl.create(:simple_contractx_contract, :void => false, :last_updated_by_id => @u.id, :project_id => @proj.id)
      @contract1 = FactoryGirl.create(:simple_contractx_contract, :void => false, :last_updated_by_id => @u.id, :project_id => @proj1.id)
    end
      
    render_views
    
    describe "GET 'index'" do
      it "returns all payments for regular user" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "InPaymentx::Payment.scoped.order('created_at')")
        session[:employee] = true
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.create(:in_paymentx_payment, :last_updated_by_id => @u.id, :project_id => @proj.id)
        qs1 = FactoryGirl.create(:in_paymentx_payment, :last_updated_by_id => @u.id)
        get 'index' , {:use_route => :in_paymentx}
        assigns(:payments).should =~ [qs, qs1]       
      end
      
      it "should return payments for the project" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "InPaymentx::Payment.scoped.order('created_at')")
        session[:employee] = true
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.create(:in_paymentx_payment,  :last_updated_by_id => @u.id, :project_id => @proj.id)
        qs1 = FactoryGirl.create(:in_paymentx_payment, :last_updated_by_id => @u.id, :project_id => @proj1.id)
        get 'index' , {:use_route => :in_paymentx, :project_id => @proj.id}
        assigns(:payments).should eq([qs])
      end
    end
  
    describe "GET 'new'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:employee] = true
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        get 'new' , {:use_route => :in_paymentx, :project_id => @proj.id, :contract_id => @contract.id}
        response.should be_success
      end
      
    end
  
    describe "GET 'create'" do
      it "redirect for a successful creation" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:employee] = true
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.attributes_for(:in_paymentx_payment, :project_id => @proj.id, :contract_id => @contract.id)
        get 'create' , {:use_route => :in_paymentx,  :payment => qs, :project_id => @proj.id, :contract_id => @contract.id}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      end
      
      it "should render 'new' if data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:employee] = true
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.attributes_for(:in_paymentx_payment, :paid_amount => nil, :contract_id => @contract.id, :project_id => @proj.id)
        get 'create' , {:use_route => :in_paymentx, :project_id => @proj.id, :payment => qs, :contract_id => @contract.id}
        response.should render_template("new")
      end
    end
  
    describe "GET 'edit'" do
      
      it "returns http success for edit" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:employee] = true
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.create(:in_paymentx_payment, :project_id => @proj.id, :contract_id => @contract.id)
        get 'edit' , {:use_route => :in_paymentx, :project_id => @proj.id, :id => qs.id, :contract_id => @contract.id}
        response.should be_success
      end
      
    end
  
    describe "GET 'update'" do
      
      it "redirect if success" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:employee] = true
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.create(:in_paymentx_payment)
        get 'update' , {:use_route => :in_paymentx, :project_id => @proj.id, :id => qs.id, :contract_id => @contract.id, :payment => {:payment_via => 'true'}}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      end
      
      it "should render 'new' if data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:employee] = true
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.create(:in_paymentx_payment)
        get 'update' , {:use_route => :in_paymentx, :project_id => @proj.id, :id => qs.id, :contract_id => @contract.id, :payment => {:paid_amount => nil}}
        response.should render_template("edit")
      end
    end
  
    describe "GET 'show'" do
      
      it "should show" do
        user_access = FactoryGirl.create(:user_access, :action => 'show', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:employee] = true
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.create(:in_paymentx_payment, :project_id => @proj.id, :contract_id => @contract.id)
        get 'show' , {:use_route => :in_paymentx, :id => qs.id}
        response.should be_success
      end
    end
  
  end
end
