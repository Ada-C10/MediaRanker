Rails.application.routes.draw do
  root 'works#top'

  resources :works do
    post 'upvote'
  end

  resources :users

  resources :sessions, only: [:new, :create]
  # post '/login', to: 'sessions#login', as: 'login'
  post '/logout', to: 'sessions#logout', as: 'logout'

end
