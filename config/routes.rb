Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'mediaranker#main'

  resources :mediaranker, only: [:main]

  resources :works do
    post 'vote', to: 'works#upvote', as: 'upvote'
  end

  resources :users, only: [:index, :show, :create]

  resources :sessions, only: [:new, :create]
  post '/sessions/logout', to: 'sessions#logout', as: 'logout'

end
