Rails.application.routes.draw do
  get '/home', to: 'home#index'
  root 'home#index'


  resources :votes

  resources :works do
    resources :votes, only: [:create]
  end

  resources :users do
    resources :votes, only: [:create]
  end

  resources :sessions, only: [:new, :create]
  post '/sessions/logout', to: 'sessions#logout', as: 'logout'
end
