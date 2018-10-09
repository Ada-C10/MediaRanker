Rails.application.routes.draw do
  root 'home#index'

  post 'sessions/login', to: 'sessions#login', as: 'login'
  get 'sessions/login', to: 'sessions#new'
  delete 'sessions/destroy', to: 'sessions#destroy', as: 'logout'

  resources :works
  resources :users, only: [:index, :show, :new, :create]
end
