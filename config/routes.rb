Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'works#home'

  resources :works do
    member do
      post 'upvote'
    end
  end
  # post '/works/:id/upvote', to: 'works#vote', as: 'vote'

  resources :users






  resources :sessions, only: [:new, :create]
  post '/sessions/logout', to: 'sessions#logout', as: 'logout'


end
