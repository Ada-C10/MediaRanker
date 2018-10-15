Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'homes#index'
  get '/homes', to: 'homes#index'

  resources :works do
    resources :votes, only: [:new, :create]
  end
  resources :users, except: :update

  resources :sessions, only: [:new, :create]
  post '/sessions/logout', to: 'sessions#logout', as: 'logout'


end
