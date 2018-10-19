Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'works#main'

  resources :works

  resources :users, only: [:show, :index, :new, :create]

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  post 'works/:id/upvote', to: 'votes#upvote', as: 'new_vote'
end
