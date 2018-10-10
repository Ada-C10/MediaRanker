Rails.application.routes.draw do

  root 'works#main'

  # resources :votes

  resources :users
  post 'users/login', to: 'users#login', as: 'login'

  # resources :works
  resources :works do
    resources :votes, only: [:create]
  end

  # post 'works/upvote', to: 'works#upvote', as 'upvote'


# get 'sessions/new to: session#new sessions
# get sessions destroy to sessions destory as logout
end
