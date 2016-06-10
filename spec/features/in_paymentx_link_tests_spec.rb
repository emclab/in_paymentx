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
         'mini-link'    => mini_btn +  'btn btn-link',
         'right-span#'         => '2', 
               'left-span#'         => '6', 
               'offset#'         => '2',
               'form-span#'         => '4'
        }
    before(:each) do
      config_entry = FactoryGirl.create(:engine_config, :engine_name => 'rails_app', :engine_version => nil, :argument_name => 'SESSION_TIMEOUT_MINUTES', :argument_value => 30)
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      @payment_type = FactoryGirl.create(:engine_config, :engine_name => 'in_paymentx', :engine_version => nil, :argument_name => 'payment_via', :argument_value => 'Cash, Check, Coupon, Credit Card, Credit Letter')
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      
      ua1 = FactoryGirl.create(:user_access, :action => 'index', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "InPaymentx::Payment.order('created_at DESC')")
      ua1 = FactoryGirl.create(:user_access, :action => 'create', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      ua1 = FactoryGirl.create(:user_access, :action => 'update', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      ua1 = FactoryGirl.create(:user_access, :action => 'show', :resource => 'in_paymentx_payments', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")      
           
      @proj = FactoryGirl.create(:commonx_misc_definition, :for_which => 'project')
      @contract = FactoryGirl.create(:commonx_misc_definition, :for_which => 'contract')
      
      visit '/'
      #save_and_open_page
      fill_in "login", :with => @u.login
      fill_in "password", :with => @u.password
      click_button 'Login'
      
    end
    it "works! (now write some real specs)" do
      qs = FactoryGirl.create(:in_paymentx_payment, :last_updated_by_id => @u.id, :project_id => @proj.id)
      visit in_paymentx.payments_path
      expect(page).to have_content('Payments')
      expect(Authentify::SysLog.all.count).to eq(1)
      expect(Authentify::SysLog.all.first.resource).to eq('in_paymentx/payments')
      expect(Authentify::SysLog.all.first.user_id).to eq(@u.id)
      save_and_open_page
      visit in_paymentx.payments_path
      #save_and_open_page
      click_link('Edit')
      save_and_open_page
      expect(page).to have_content('Edit Payment')
      fill_in 'payment_paid_amount', with: 10
      fill_in 'payment_brief_note', with: 'Edit brief note field'
      click_button 'Save'
      visit in_paymentx.payments_path
      click_link('Edit')
      expect(page).to have_content('Edit brief note field')
           
      visit in_paymentx.payments_path(:project_id => @proj.id, :contract_id => @contract.id)
      click_link('New Payment')
      #save_and_open_page
      expect(page).to have_content('New Payment')
      fill_in 'payment_paid_amount', with: 10
      fill_in 'payment_brief_note', with: 'Creating a new payment'
      fill_in 'payment_received_date', with: Date.today
      click_button 'Save'
      visit in_paymentx.payments_path(:project_id => @proj.id, :contract_id => @contract.id)
      expect(page).to have_content('Creating a new payment')
      
      
    end
  end
end
