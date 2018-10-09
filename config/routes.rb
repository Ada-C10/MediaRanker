Rails.application.routes.draw do
  post 'sessions/login', to: 'sessions#login', as: 'login'
  get 'sessions/new', to: 'session#new', as: 'new_session'
  get 'sessions/destroy', to: 'session#destroy', as: 'logout'
  # need to update below to exclude routes we do not need
  resources :works
  resources :users
  resources :votes
  root to: 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
