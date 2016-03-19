# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment_requestx_payment_request, :class => 'PaymentRequestx::PaymentRequest' do
    resource_string "MyString"
    resource_id 1
    last_updated_by_id 1
    void false
    requested_by_id 1
    amount "9.99"
    brief_note "MyString"
    request_date "2013-09-08"
    estimated_pay_date "2013-09-08"
    approved false
    approved_date "2013-09-08"
    paid false
    paid_date "2013-09-08"
    project_id 1
    wf_state 'initial_state'
    fort_token '123456789'
  end
end
