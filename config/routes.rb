Rails.application.routes.draw do
  namespace :admin do
    resources :users
    root to: "users#index"
  end
  root to: 'visitors#index'
  devise_for :users
  resources :users
  #FIXME should i nest the rounds?
  resources :rounds, only: [:update]
  patch "/rounds/:id/winner", to: "rounds#winner" #FIXME better way to have a route for this
  resources :games, only: [:new, :index, :update, :create, :show] do 
    patch '/join', to: 'games#join'
    patch '/start', to: 'games#start'
  end
  
end
