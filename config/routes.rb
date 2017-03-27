InPaymentx::Engine.routes.draw do
  
  resources :payments do
    collection do
      get :search
      get :search_results
      get :stats
      get :stats_results 
      get :payer_name_autocomplete
    end
  end
  
  root :to => 'payments#index'
end
