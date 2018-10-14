Rails.application.routes.draw do
  root 'works#home'

  post 'users/login', to: 'users#login', as: 'login'
  get 'users/login', to: 'users#new'
  delete 'users/destroy', to: 'users#destroy', as: 'logout'

  resources :works
  resources :users, only:[:index, :show]

  post '/works/:id/upvote', to: 'works#upvote', as: 'upvote'

end
