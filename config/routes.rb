Recipes::Application.routes.draw do
  get "login" => "sessions#new"
  get "logout" => "sessions#destroy"

  resources :recipes do
    collection do
      get 'import'
      get 'search'
      post 'create_from_import', :as => :create_from_import
    end
  end
  
  resources :users
  resources :sessions
  
  root :to => "recipes#index"

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end
end
