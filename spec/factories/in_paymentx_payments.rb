# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :in_paymentx_payment, :class => 'InPaymentx::Payment' do
    contract_id 1
    project_id 1
    last_updated_by_id 1
    paid_amount "9.99"
    received_date "2013-11-12"
    received_by_id 1
    brief_note "My a note Text"
    payment_via "wired"
  end
end
