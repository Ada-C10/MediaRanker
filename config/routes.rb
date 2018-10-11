Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'works#homepage'

  resources :users
  resources :votes
  resources :works
  resources :sessions, only: [:new, :create, :delete]
  post '/sessions/logout', to: 'sessions#logout', as: 'logout'

  get '/home', to: 'works#homepage', as: 'home'
end
