Rails.application.routes.draw do
  get 'sessions/login', to: 'sessions#new'
  post 'sessions/login', to: 'sessions#login', as: 'login'
  delete 'sessions/destroy', to: 'sessions#destroy', as: 'logout'

  get 'users/index', to: 'users#index', as: 'users'
  get 'users/show', to: 'users#show', as: 'user'

  root 'welcome#index'

  post 'works/:id/upvote', to: 'works#upvote', as: 'upvote'
  resources :works


  resources :users, only: [:index, :show, :new]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
