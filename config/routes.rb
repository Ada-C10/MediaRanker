Rails.application.routes.draw do
  root 'works#index'

  resources :users
  resources :votes
  resources :works
end
