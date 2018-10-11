Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'mediaranker#index'

  resources :mediaranker, only: [:index]

  resources :works do
    post 'vote', to: 'works#upvote', as: 'upvote'
  end

  resources :users, only: [:index, :show]

  resources :sessions, only: [:new, :create]
  post '/sessions/logout', to: 'sessions#logout', as: 'logout'

end
