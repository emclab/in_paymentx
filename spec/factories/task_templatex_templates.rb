# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task_templatex_template, :class => 'TaskTemplatex::Template' do
    name "MyString"
    type_id 1
    active true
    last_updated_by_id 1
    instruction "MyText"
    ranking_order 1
  end
end
