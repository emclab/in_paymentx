require_dependency "in_paymentx/application_controller"

module InPaymentx
  class PaymentsController < ApplicationController
    before_filter :require_employee
    before_filter :load_parent_record


    def index
      @title = t('Payments')
      @payments = params[:in_paymentx_payments][:model_ar_r]
      @payments = @payments.where(:project_id => @project.id) if @project
      @payments = @payments.where(:contract_id => @contract.id) if @contract      
      @payments = @payments.page(params[:page]).per_page(@max_pagination)     
      @erb_code = find_config_const('payment_index_view', 'in_paymentx')
    end


    def new
      @title = t('New Payment')
      @payment = InPaymentx::Payment.new
    end


    def create
      @payment = InPaymentx::Payment.new(params[:payment], :as => :role_new)
      @payment.last_updated_by_id = session[:user_id]
      if @payment.save
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      else
        flash[:notice] = t('Data Error. Not Saved!')
        render 'new'
      end
    end

    def edit
      @title = t('Edit Payment')
      @payment = InPaymentx::Payment.find_by_id(params[:id])
    end

    def update
      @payment = InPaymentx::Payment.find_by_id(params[:id])
      @payment.last_updated_by_id = session[:user_id]
      if @payment.update_attributes(params[:payment], :as => :role_update)
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      else
        flash[:notice] = t('Data Error. Not Updated!')
        render 'edit'
      end
    end

    def show
      @title = t('Payment Info')
      @payment = InPaymentx::Payment.find_by_id(params[:id])
      @erb_code = find_config_const('payment_show_view', 'in_paymentx')
    end

    protected
    
    def load_parent_record
      @contract = InPaymentx.contract_class.find_by_id(params[:contract_id]) if params[:contract_id].present? 
      @project = InPaymentx.project_class.find_by_id(params[:project_id]) if params[:project_id].present? 
      @contract = InPaymentx.contract_class.find_by_id(InPaymentx::Payment.find_by_id(params[:id]).contract_id) if params[:id].present? 
      @project = InPaymentx.project_class.find_by_id(InPaymentx::Payment.find_by_id(params[:id]).project_id) if params[:id].present? 
    end

  end
end
