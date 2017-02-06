Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ru/ do
    resources :decks
    resources :cards
    resources :users, only: [:new, :create, :edit, :update]
    resources :user_sessions, only: [:new, :create, :destroy]

    put '/users/:id/set_current/:deck_id' => 'users#set_current_deck', :as => 'set_deck'

    get 'login' => 'user_sessions#new', :as => :login
    post 'logout' => 'user_sessions#destroy', :as => :logout
    root 'home#index'
  end

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  get '/' => 'home#index'
  post 'home' => 'home#check'
end
