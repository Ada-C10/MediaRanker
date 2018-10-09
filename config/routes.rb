Rails.application.routes.draw do
  # create session for user login
  post 'sessions/login', to: 'sessions#login', as: 'login'
  get 'sessions/login'
  get 'sessions/new', to: 'sessions#new', as: 'new_session'
  get 'sessions/destroy', to: 'sessions#destroy', as: 'logout'
  root "works#index"
  resources :works
  get 'works/index'
  get 'works/show'
  get 'works/update'
  get 'works/create'
  get 'works/new'
  get 'works/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
