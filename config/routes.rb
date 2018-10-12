Rails.application.routes.draw do
  root "works#index"

  resources :users
  resources :votes, only: [:create, :destroy]
  # create session for user login
  post 'sessions/login', to: 'sessions#login', as: 'login'
  # route to sessions new with login form
  get 'sessions/login', to: 'sessions#new'
  delete 'sessions/destroy', to: 'sessions#destroy', as: 'logout'

  
  get 'works/top', to: 'works#top', as: 'works_top'
  get 'works/spotlight', to: 'works#spotlight', as: 'works_spotlight'
  resources :works
  

  # custom routes to up or downvote works
  patch '/works/:id/upvote', to: 'works#upvote', as: 'works_upvote'
  patch '/works/:id/downvote', to: 'works#downvote', as: 'works_downvote'
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
