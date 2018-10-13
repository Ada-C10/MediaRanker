Rails.application.routes.draw do
  post '/login', to: 'sessions#login', as: 'login'
  get '/login', to: 'sessions#new', as: 'new_session'
  delete 'sessions/destroy', to: 'sessions#destroy', as: 'logout'

  resources :users, only: [:index, :show]
  resources :works
  post 'works/:id/upvote', to: 'works#upvote', as: 'upvote'

  root to: 'pages#home'
end
