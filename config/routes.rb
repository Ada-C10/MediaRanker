Rails.application.routes.draw do
  # Custom Routes
  get 'works/:id/upvote', to: 'works#upvote', as: 'upvote'
  post 'sessions/login', to: 'sessions#login', as: 'login'
  get 'sessions/login', to: 'sessions#new', as: 'new_session'
  delete 'sessions/destroy', to: 'sessions#destroy', as: 'logout'

  # Home Page
  root 'pages#home'

  # Restful Routes
  resources :works
  resources :users, only: [:index, :show]
end
