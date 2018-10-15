Rails.application.routes.draw do

  post 'users/login', to: 'users#login', as: 'login'
  get 'users/login', to: 'users#new'
  delete 'users/logout', to: 'users#destroy', as: 'logout'

  root 'main#index'
  resources :works

  post 'works/:id/upvote', to: 'works#upvote', as: 'upvote'

  get 'users', to: 'users#index', as: 'users'
  get 'users/:id', to: 'users#show', as: 'user'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
