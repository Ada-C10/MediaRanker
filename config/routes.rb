Rails.application.routes.draw do
  get '/home', to: 'home#index'
  root 'home#index'

  resources :works
  resources :users

  resources :sessions, only: [:new, :create]
  post '/sessions/logout', to: 'sessions#logout', as: 'logout'

  post 'works/:id/upvote', to:'works#upvote', as: 'upvote'
end
