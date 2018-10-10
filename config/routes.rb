Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'works#welcome'

  resources :works
  get '/works/welcome', to: 'works#welcome', as: 'welcome'

  resources :users
  
  resources :votes

  resources :sessions, only:[:new]
  post 'sessions/login', to: 'sessions#login', as: 'login'
  post 'sessions/logout', to: 'sessions#logout', as: 'logout'
end
