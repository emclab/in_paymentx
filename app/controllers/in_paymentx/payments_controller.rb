require_dependency "in_paymentx/application_controller"

module InPaymentx
  class PaymentsController < ApplicationController
    before_action :require_employee
    before_action :load_parent_record


    def index
      @title = t('Payments')
      @payments = params[:in_paymentx_payments][:model_ar_r]
      @payments = @payments.where(:project_id => @project.id) if @project
      @payments = @payments.where(:contract_id => @contract.id) if @contract      
      @payments = @payments.page(params[:page]).per_page(@max_pagination)     
      @erb_code = find_config_const('payment_index_view', session[:fort_token], 'in_paymentx')
    end


    def new
      @title = t('New Payment')
      @payment = InPaymentx::Payment.new
      @erb_code = find_config_const('payment_new_view', session[:fort_token], 'in_paymentx')
    end


    def create
      @payment = InPaymentx::Payment.new(new_params)
      @payment.last_updated_by_id = session[:user_id]
      @payment.fort_token = session[:fort_token]
      if @payment.save
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Saved!")
      else
        #for render new when data error
        @contract = InPaymentx.contract_class.find_by_id(params[:payment][:contract_id]) if params[:payment].present? && params[:payment][:contract_id].present? 
        @project = InPaymentx.project_class.find_by_id(params[:payment][:project_id]) if params[:payment].present? && params[:payment][:project_id].present? 
        @erb_code = find_config_const('payment_new_view', session[:fort_token], 'in_paymentx')
        flash[:notice] = t('Data Error. Not Saved!')
        render 'new'
      end
    end

    def edit
      @title = t('Edit Payment')
      @payment = InPaymentx::Payment.find_by_id(params[:id])
      return nil if @payment.fort_token != session[:fort_token]
      @erb_code = find_config_const('payment_edit_view', session[:fort_token], 'in_paymentx')
    end

    def update
      @payment = InPaymentx::Payment.find_by_id(params[:id])
      return nil if @payment.fort_token != session[:fort_token]
      @payment.last_updated_by_id = session[:user_id]
      if @payment.update_attributes(edit_params)
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Updated!")
      else
        @erb_code = find_config_const('payment_edit_view', session[:fort_token], 'in_paymentx')
        flash[:notice] = t('Data Error. Not Updated!')
        render 'edit'
      end
    end

    def show
      @title = t('Payment Info')
      @payment = InPaymentx::Payment.find_by_id(params[:id])
      @erb_code = find_config_const('payment_show_view', session[:fort_token], 'in_paymentx')
    end

    protected
    
    def load_parent_record
      @contract = InPaymentx.contract_class.find_by_id(params[:contract_id]) if params[:contract_id].present? 
      @project = InPaymentx.project_class.find_by_id(params[:project_id]) if params[:project_id].present? 
      @contract = InPaymentx.contract_class.find_by_id(InPaymentx::Payment.find_by_id(params[:id]).contract_id) if params[:id].present? 
      @project = InPaymentx.project_class.find_by_id(InPaymentx::Payment.find_by_id(params[:id]).project_id) if params[:id].present? 
      
    end
    
    private
    
    def new_params
      params.require(:payment).permit(:paid_amount, :received_by_id, :brief_note, :received_date, :payment_via, :contract_id, :project_id)
    end
    
    def edit_params
      params.require(:payment).permit(:paid_amount, :received_by_id, :brief_note, :received_date, :payment_via, :contract_id, :project_id)
    end

  end
end
