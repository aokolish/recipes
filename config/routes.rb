Recipes::Application.routes.draw do

  get "login" => "sessions#new"
  get "logout" => "sessions#destroy"
  get "favorites" => "favorites#index"

  resources :recipes do
    collection do
      get 'import'
      get 'search'
      post 'create_from_import', :as => :create_from_import
    end

    resources :pictures do
      collection { post :sort }
    end
  end

  resources :users do
    resources :favorites
  end

  resources :sessions

  root :to => "static#home"
end
