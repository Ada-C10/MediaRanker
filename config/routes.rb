Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
  resources :media
  resources :users, only: [:index, :new, :create]
  post '/media/:id/upvote', to: 'users#upvote', as: 'upvote'
  get '/pages/home', to: 'pages#home', as: 'home'
  post '/users/logout', to: 'users#logout', as: 'logout'
end
