Rails.application.routes.draw do
  post '/login', to: 'sessions#login', as: 'login'
  get '/login', to: 'sessions#new', as: 'new_session'
  delete 'sessions/destroy', to: 'session#destroy', as: 'logout'
  # need to update below to exclude routes we do not need
  resources :works
  resources :users
  resources :votes
  root to: 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
