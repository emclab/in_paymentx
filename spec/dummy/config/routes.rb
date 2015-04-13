Rails.application.routes.draw do

  mount InPaymentx::Engine => "/in_paymentx"
  mount Commonx::Engine => "/commonx"
  mount Authentify::Engine => '/authentify'
  mount ExtConstructionProjectx::Engine => '/projectx'
  mount SimpleContractx::Engine => '/contractx'
  mount Kustomerx::Engine => '/kustomerx'
  mount Searchx::Engine => '/searchx'
  mount PaymentRequestx::Engine => '/pr'
  
  
  root :to => "authentify/sessions#new"
  get '/signin',  :to => 'authentify/sessions#new'
  get '/signout', :to => 'authentify/sessions#destroy'
  get '/user_menus', :to => 'user_menus#index'
  get '/view_handler', :to => 'authentify/application#view_handler'
end
