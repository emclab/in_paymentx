# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :kustomerx_customer, :class => 'Kustomerx::Customer' do
    name "My name"
    short_name "My short"
    since_date "2013-10-13"
    shipping_instruction "MyText"
    zone_id 1
    customer_status_category_id 1
    phone "12345555"
    fax "3443222"
    sales_id 1
    active true
    last_updated_by_id 1
    quality_system_id 1
    employee_num "MyString"
    revenue "MyString"
    customer_eval "MyText"
    main_biz "MyText"
    customer_specific "MyText"
    note "MyText"
    web "MyString"
  end
end
