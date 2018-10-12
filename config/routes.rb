Rails.application.routes.draw do

  root 'works#main'
  get 'works/:id/votes', to: 'works#upvote', as: 'work_upvote'
  post 'sessions/login', to: 'sessions#login', as: 'login'
  get 'sessions/login', to: 'sessions#new'
  delete 'sessions/destroy', to: 'sessions#destroy', as: 'logout'

  resources :works
  resources :users
end
