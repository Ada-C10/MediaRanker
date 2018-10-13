Rails.application.routes.draw do
  # Lets user login when they submit login form
  post 'sessions/login', to: 'sessions#login', as: 'login'
  # Brings up login form (get request)
  get 'sessions/login', to: 'sessions#new', as: 'new_session'
  # destroying the session
  delete 'sessions/destroy', to: 'sessions#destroy', as: 'logout'

  root 'welcome#index'

  resources :welcome, only:[:index]

  resources :works

  put '/works/:id/upvote', to: 'works#upvote', as: 'upvote'

# Only need user routes for new/show ?
  resources :users, except:[:destroy, :create, :edit, :update]


end
