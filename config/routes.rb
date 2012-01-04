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

  resources :users do
    resources :favorites
  end

  resources :sessions

  root :to => "recipes#index"
end
