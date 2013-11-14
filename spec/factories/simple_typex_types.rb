# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :simple_typex_type, :class => 'SimpleTypex::Type' do
    name "MyString"
    active false
    brief_note "MyText"
    last_updated_by_id 1
    ranking_order 1
  end
end
