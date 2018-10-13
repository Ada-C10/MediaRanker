Rails.application.routes.draw do

  root 'works#main'
  resources :users
  resources :works
  post 'works/:id/upvote', to: 'works#upvote', as: 'upvote'
  post 'sessions/login', to: 'sessions#login', as: 'login'
  get 'sessions/login', to: 'sessions#new'
  delete 'sessions/destroy', to: 'sessions#destroy', as: 'logout'

end
