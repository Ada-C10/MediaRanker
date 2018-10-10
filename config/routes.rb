Rails.application.routes.draw do
  get '/home', to: 'home#index'
  root 'home#index'

  resources :users
  resources :votes
  resources :works


end
