Rails.application.routes.draw do
  root 'works#main'
  resources :works
  resources :votes

resources :users
  post 'users/login', to: 'users#login', as: 'login'
  delete 'users/destroy', to: 'users#destroy', as: 'logout'


post 'works/upvote', to: 'works#upvote', as: 'upvote'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
