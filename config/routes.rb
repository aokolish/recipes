Recipes::Application.routes.draw do
  get "static/home"

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

  root :to => "static#home"
end
