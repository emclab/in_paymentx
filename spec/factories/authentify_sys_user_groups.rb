# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sys_user_group, class: 'Authentify::SysUserGroup'  do
    user_group_name "MyString"
    group_type 1
    manager_group_id  30
    zone_id 1
    short_note "MyString"
  end
end
