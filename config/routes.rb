Rails.application.routes.draw do
  get 'votes/create'
  post '/login', to: 'sessions#login', as: 'login'
  get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  post '/works/:id/upvote', to: 'votes#create', as: 'upvote'

  root 'works#main'

  resources :works
  resources :users, except: [:update, :edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
