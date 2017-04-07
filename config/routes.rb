Rails.application.routes.draw do
  namespace :admin do
    resources :users
    root to: "users#index"
  end
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :games, only: [:new, :index, :update, :create, :show]
  post '/join/:id', to: 'games#join'
end
