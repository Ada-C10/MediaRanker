Rails.application.routes.draw do


  root 'votes#index'

  resources :votes
  resources :users
  resources :works

  # post '/works/:id/upvote' to: 'votes#upvote', as: 'upvote'

  resources :sessions, only: [:new, :create]
  post '/sessions/logout', to: 'sessions#logout', as: 'logout'

end
