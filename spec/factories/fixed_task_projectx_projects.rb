# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fixed_task_projectx_project, :class => 'FixedTaskProjectx::Project' do
    name "My project String"
    project_num "MyString"
    task_template_id 1
    project_desp "My desp Text"
    sales_id 1
    start_date "2013-10-31"
    end_date "2013-10-31"
    delivery_date "2013-10-31"
    est_delivery_date "2013-10-31"
    instruction "My instrudtion Text"
    project_manager_id 1
    cancelled false
    completed false
    last_updated_by_id 1
    expedite false
    status_id 1
    customer_id 1
  end
end
