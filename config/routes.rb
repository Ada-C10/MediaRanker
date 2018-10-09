Rails.application.routes.draw do

  root to: 'works#main'

  get '/works/main', to: 'works#main', as: 'main_works'

  resources :users
  resources :works
  post '/works/:id/upvote', to: 'works#upvote', as: 'upvote_work'


  resources :sessions, only: [:new, :create]
  post '/sessions/logout', to: 'sessions#logout', as: 'logout'

end
