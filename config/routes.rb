Rails.application.routes.draw do
  root "works#index"

  resources :users
  # create session for user login
  post 'sessions/login', to: 'sessions#login', as: 'login'
  # route to sessions new with login form
  get 'sessions/login', to: 'sessions#new'
  delete 'sessions/destroy', to: 'sessions#destroy', as: 'logout'

  resources :works
  # get 'works/index'
  # get 'works/show'
  # get 'works/update'
  # get 'works/create'
  # get 'works/new'
  # get 'works/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
