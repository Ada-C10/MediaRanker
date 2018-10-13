Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'works#index'

  resources :works do
    resources :votes, only: [:create, :destroy]
  end

  resources :votes

  resources :sessions, only: [:new, :create]
  post '/sessions/logout', to: 'sessions#logout', as: 'logout'

  resources :users

  get '/login', to: 'users#new'
end
