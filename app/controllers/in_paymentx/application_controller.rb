module InPaymentx
  class ApplicationController < ::ApplicationController
    include Authentify::SessionsHelper
    include Authentify::AuthentifyUtility
    include Authentify::UsersHelper
    include Authentify::UserPrivilegeHelper
    include Commonx::CommonxHelper
    include Searchx::SearchHelper
    
    #before_action :require_signin
    before_action :max_pagination
    before_action :check_access_right 
    before_action :load_session_variable, :only => [:new, :edit]  #for parent_record_id & parent_resource in check_access_right
    after_action :delete_session_variable, :only => [:create, :update]  #for parent_record_id & parent_resource in check_access_right
    
    helper_method :return_customers_by_access_right, :return_projects_by_access_right, :has_action_right?, :readonly?
    protected
  
    def max_pagination
      @max_pagination = find_config_const('pagination', session[:fort_token])
    end
    
    #engine's
    def return_customers_by_access_right     
      access_rights, model_ar_r, has_record_access = access_right_finder('index', InPaymentx.customer_class.to_s.underscore.pluralize)
      return [] if access_rights.blank?
      return model_ar_r #instance_eval(access_rights.sql_code) #.present?
    end
    
    def return_projects_by_access_right     
      access_rights, model_ar_r, has_record_access = access_right_finder('index', InPaymentx.project_class.to_s.underscore.pluralize)
      return [] if access_rights.blank?
      return model_ar_r #instance_eval(access_rights.sql_code) #.present?
    end
  end
end
