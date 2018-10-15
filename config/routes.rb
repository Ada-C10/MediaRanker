Rails.application.routes.draw do
  root 'works#top_works'

  get 'sessions/login', to: 'sessions#login', as: 'login'
  post 'sessions/login', to: 'sessions#login'
  delete 'sessions/logout', to: 'sessions#destroy', as: 'logout'

  post 'works/:work_id/votes/create', to: 'votes#create', as: 'vote'

  # get 'works/index'
  # get 'works/new'

  resources :works
  resources :users


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
