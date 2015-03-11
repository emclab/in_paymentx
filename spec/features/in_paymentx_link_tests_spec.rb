require 'rails_helper'

RSpec.describe "LinkTests", type: :request do
  describe "GET /in_paymentx_link_tests" do
    mini_btn = 'btn btn-mini '
    ActionView::CompiledTemplates::BUTTONS_CLS =
        {'default' => 'btn',
         'mini-default' => mini_btn + 'btn',
         'action'       => 'btn btn-primary',
         'mini-action'  => mini_btn + 'btn btn-primary',
         'info'         => 'btn btn-info',
         'mini-info'    => mini_btn + 'btn btn-info',
         'success'      => 'btn btn-success',
         'mini-success' => mini_btn + 'btn btn-success',
         'warning'      => 'btn btn-warning',
         'mini-warning' => mini_btn + 'btn btn-warning',
         'danger'       => 'btn btn-danger',
         'mini-danger'  => mini_btn + 'btn btn-danger',
         'inverse'      => 'btn btn-inverse',
         'mini-inverse' => mini_btn + 'btn btn-inverse',
         'link'         => 'btn btn-link',
         'mini-link'    => mini_btn +  'btn btn-link'
        }
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
      
      ua1 = FactoryGirl.create(:user_access, :action => 'index', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "InPaymentx::Payment.scoped.order('created_at DESC')")
      ua1 = FactoryGirl.create(:user_access, :action => 'create', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      ua1 = FactoryGirl.create(:user_access, :action => 'update', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      ua1 = FactoryGirl.create(:user_access, :action => 'show', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")      
           
      @proj_type = FactoryGirl.create(:simple_typex_type)
      @proj_type1 = FactoryGirl.create(:simple_typex_type, :name => 'newnew')
      @tt = FactoryGirl.create(:task_templatex_template, :active => true, :last_updated_by_id => @u.id, :type_id => @proj_type.id)
      @tt1 = FactoryGirl.create(:task_templatex_template, :name => 'a new name', :active => true, :last_updated_by_id => @u.id, :type_id => @proj_type1.id)
      @cust = FactoryGirl.create(:kustomerx_customer)
      @proj = FactoryGirl.create(:fixed_task_projectx_project, :task_template_id => @tt.id, :customer_id => @cust.id)
      @proj1 = FactoryGirl.create(:fixed_task_projectx_project, :task_template_id => @tt1.id, :name => 'a new name', :project_num => 'something new') #, :customer_id => @cust.id)
      @contract = FactoryGirl.create(:simple_contractx_contract, :void => false, :last_updated_by_id => @u.id, :project_id => @proj.id)
      @contract1 = FactoryGirl.create(:simple_contractx_contract, :void => false, :last_updated_by_id => @u.id, :project_id => @proj1.id)
      
      visit '/'
      #save_and_open_page
      fill_in "login", :with => @u.login
      fill_in "password", :with => 'password'
      click_button 'Login'
    end
    it "works! (now write some real specs)" do
      qs = FactoryGirl.create(:in_paymentx_payment, :last_updated_by_id => @u.id, :project_id => @proj.id)
      visit in_paymentx.payments_path
      expect(page).to have_content('Payments')
      
      visit in_paymentx.payments_path
      save_and_open_page
      click_link('Edit')
      save_and_open_page
      expect(page).to have_content('Edit Payment')
      
      visit in_paymentx.payments_path(:project_id => @proj.id, :contract_id => @contract.id)
      click_link('New Payment')
      save_and_open_page
      expect(page).to have_content('New Payment')
    end
  end
end
