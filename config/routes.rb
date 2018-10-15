Rails.application.routes.draw do
  get 'users/index'
  get 'users/create'
  get 'users/new'
  get 'users/show'
  get 'users/destroy'
  root 'pages#index'
  post 'sessions/login', to: 'sessions#login', as: 'login'
  get 'sessions/login', to: 'sessions#new'
  delete 'sessions/destroy', to: 'sessions#destroy', as: 'logout'
  #post 'works/:id/upvote', to: 'works#upvote', as: 'upvote'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :works
  resources :users
  resources :works do
    # resources :votes, only: [:create]
    post 'upvote'#  # work_update path custom action replaces creates
  end
end
