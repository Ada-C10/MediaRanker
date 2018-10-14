Rails.application.routes.draw do
  root "main#index"

  resources :works do
  resources :votes, only: [:create, :new, :show]
end
  resources :users
  resources :main, only: [:index]
  post 'works/:id/upvote', to: 'works#upvote', as: 'upvote'
  post 'sessions/login', to: 'sessions#login', as: 'login'
  get 'sessions/login', to: 'sessions#new'
  delete 'sessions/destroy', to: 'sessions#destroy', as: 'logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
