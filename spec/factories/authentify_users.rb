FactoryGirl.define do
  
  factory :user, class: 'Authentify::User'  do
 
    name                  "Test User"
    login                 'testuser'
    email                 "test@test.com"
    password              "password"
    password_confirmation {password}
    status                "active"
    last_updated_by_id    1
    auth_token            "123"
    password_reset_token  nil
    password_reset_sent_at nil

    #user_levels
    #after(:build) do |user|
    #  user.user_levels << FactoryGirl.build(:user_level, :user => user)
    #end
  end
end
