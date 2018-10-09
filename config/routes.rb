Rails.application.routes.draw do
  get 'sessions/login'
  get 'sessions/new'
  get 'sessions/destroy'
  get 'sessions/index'
  get 'sessions/new'
  get 'sessions/destroy'
  get 'login/new'
  get 'login/destroy'
  root 'home#index'

  resources :works
  resources :users, only: [:index, :show, :new, :create]
end
