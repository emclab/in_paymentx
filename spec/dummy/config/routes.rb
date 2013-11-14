Rails.application.routes.draw do

  mount InPaymentx::Engine => "/in_paymentx"
  mount Commonx::Engine => "/commonx"
  mount Authentify::Engine => '/authentify'
  mount FixedTaskProjectx::Engine => '/projectx'
  mount SimpleContractx::Engine => '/contractx'
  mount Kustomerx::Engine => '/kustomerx'
  mount TemplateTaskx::Engine => '/taskx'
  mount TaskTemplatex::Engine => '/templatex'
  mount SimpleTypex::Engine => '/simple_typex'
  
  resource :session
  
  root :to => "authentify::sessions#new"
  match '/signin',  :to => 'authentify::sessions#new'
  match '/signout', :to => 'authentify::sessions#destroy'
  match '/user_menus', :to => 'user_menus#index'
  match '/view_handler', :to => 'authentify::application#view_handler'
end
