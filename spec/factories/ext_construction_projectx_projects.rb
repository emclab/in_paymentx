# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ext_construction_projectx_project, :class => 'ExtConstructionProjectx::Project' do
    name "MyString"
    customer_id 1
    status_id 1
    construction_address "MyText"
    customer_contact "MyText"
    construction_spec "MyText"
    other_spec "MyText"
    turn_over_requirement "MyText"
    completed false
    awarded false
    construction_start_date "2014-04-02"
    construction_finish_date "2014-04-02"
    turn_over_date "2014-04-02"
    project_num "MyString"
    cancelled false
    last_updated_by_id 1
    note "MyText"
  end
end
