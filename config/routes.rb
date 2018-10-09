Rails.application.routes.draw do
  post 'sessions/login', to: 'sessions#login', as: 'login'
  get 'sessions/login', to: 'sessions#new'
  delete 'sessions/destroy', to: 'sessions#destroy', as: 'logout'
  root 'pages#home'

  resources :works
  resources :users
end
