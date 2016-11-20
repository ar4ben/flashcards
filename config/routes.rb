Rails.application.routes.draw do
  resources :cards
  resources :users, only: [:new, :create, :edit, :update]
  resources :user_sessions, only: [:new, :create, :destroy]

  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  root 'home#index'
  post 'home' => 'home#check'
end
