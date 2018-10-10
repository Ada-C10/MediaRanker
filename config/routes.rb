Rails.application.routes.draw do
  get 'sessions/login'
  get 'sessions/new'
  get 'sessions/destroy'

  get 'users/index'
  get 'users/show'

  root 'welcome#index'

  resources :works
  get 'works/:id/upvote', to: 'works#upvote', as: 'upvote_work'
  resources :users, only: [:index, :show, :new]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
