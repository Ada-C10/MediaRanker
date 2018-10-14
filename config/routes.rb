Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'users/login', to: 'sessions#login', as: 'login' #lets users login
  get 'users/login', to: 'sessions#new', as: 'new_session' #gets the login form
  delete 'users/destroy', to: 'sessions#destroy', as: 'logout' #logging out

  root "works#index"

  resources :works do
    resources :votes, only: [:create]
  end

  resources :users,
    only: [:index, :show]
  end
  # get '/works', to: 'works#index', as: "works"
  #
  # get '/works/new', to: 'works#new', as: "new_work"
  # post '/works', to: 'works#create'
  #
  # get '/works/:id/edit', to: 'works#edit', as: 'edit_work'
  #
  # get '/works/:id', to: 'works#show', as: "work"
  #
  # patch '/works/:id', to: 'works#update', as: "update_work"
  # put '/works/:id', to: 'works#update'
  #
  # delete '/works/:id', to: 'works#destroy', as: "delete_work"

  # resources :votes
