InPaymentx::Engine.routes.draw do
  
  resources :payments do
    collection do
      get :search
      get :search_results
      get :stats
      get :stats_results 
    end
  end
  
  root :to => 'payments#index'
end
