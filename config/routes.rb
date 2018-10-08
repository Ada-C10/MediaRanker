Rails.application.routes.draw do
  root 'mediaranker#index'

  resources :mediaranker, only: [:index]

  resources :works

  resources :votes

  resources :users
end
