Rails.application.routes.draw do
  get 'home/index'
  root to: 'home#index'

  resources :sessions, only: [:new, :create]
  post '/sessions/logout', to: 'sessions#logout', as: 'logout'

  resources :users, only: [:index, :show]

  resources :works do
    resources :votes, only: [:create]
  end
end
