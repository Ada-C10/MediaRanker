Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'works#homepage'

  resources :votes, only: [:index, :show, :create]

  resources :works do
    resources :votes, only: [:index, :create, :update]
  end



  resources :users do
    resources :votes, only: [:index, :create]
  end

  resources :sessions, only: [:new, :create]

  post '/sessions/logout', to: 'sessions#logout', as: 'logout'

  post '/works/upvote', to: 'works#upvote', as: 'upvote'

  get '/home', to: 'works#homepage', as: 'home'


end
