Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ru/ do
    namespace :dashboard do
      resources :decks
      resources :cards
      resources :users, only: [:new, :create, :edit, :update]

      put '/users/:id/set_current/:deck_id' => 'users#set_current_deck', :as => 'set_deck'
      root 'home#index'
      post 'home' => 'home#check'
    end

    namespace :home do
      resources :user_sessions, only: [:new, :create, :destroy]
      get 'login' => 'user_sessions#new', :as => :login
      post 'logout' => 'user_sessions#destroy', :as => :logout
    end
  end

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  get '/' => 'dashboard/home#index'
end
