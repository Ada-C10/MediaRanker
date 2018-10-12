Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'works#index'

  resources :works do
    resources :votes, only: [:create]
  end

  resources :users do
    resources :works, except: [:index, :show]
    resources :votes, only: [:create]
  end

  resources :votes do
    resources :works, only: [:index, :show]
    resources :users, only: [:index, :show]
  end

  resources :sessions, only: [:new, :create]
  post '/sessions/logout', to: 'sessions#logout', as: 'logout'

  # get '/works', to: 'works#index', as: 'all_works'
  #
  # get '/works/new', to: 'works#new', as: 'new_work'
  # post "/works", to: "works#create"
  #
  #
  # get '/works/:id/edit', to: 'works#edit', as: 'edit_work'
  # patch '/works/:id', to: 'works#update'
  #
  # delete '/works/:id', to: 'works#destroy'
  #
  #
  # get '/works/:id', to: 'works#show', as: 'work'
  #
  #
  #
  #
  # get '/votes', to: 'votes#index', as: 'all_votes'
  #
  # get '/votes/new', to: 'votes#new', as: 'new_vote'
  # post "/votes", to: "votes#create"
  #
  #
  # get '/votes/:id/edit', to: 'votes#edit', as: 'edit_vote'
  # patch '/votes/:id', to: 'votes#update'
  #
  # delete '/votes/:id', to: 'votes#destroy'
  #
  #
  # get '/votes/:id', to: 'votes#show', as: 'vote'
  #
  #

end
