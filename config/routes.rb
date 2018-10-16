Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :works
  post '/works/:id/vote', to: 'works#vote', as: 'vote_work'

  resources :sessions, only: [:new, :create]
  post '/sessions/logout', to: 'sessions#logout', as: 'logout'

  resources :users

  get '/login', to: 'sessions#new'
end
