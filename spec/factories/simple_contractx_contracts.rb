# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :simple_contractx_contract, :class => 'SimpleContractx::Contract' do
    project_id 1
    contract_total "9.99"
    contract_num 'ABC223'
    payment_agreement "My agreement Text"
    paid_out false
    signed false
    sign_date "2013-11-06"
    signed_by_id 1
    contract_on_file false
    last_updated_by_id 1
    void false
    note "Mynote Text"
  end
end
