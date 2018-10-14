Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'homes#index'
  get '/homes', to: 'homes#index'

  resources :works
  resources :users, except: [:update]
  resources :votes, only: [:index, :new, :create]

  resources :sessions, only: [:new, :create]
  post '/sessions/logout', to: 'sessions#logout', as: 'logout'


end
