Rails.application.routes.draw do
  root 'works#index'

  get 'sessions/login', to: 'sessions#login', as: 'login'
  post 'sessions/login', to: 'sessions#login'
  delete 'sessions/logout', to: 'sessions#destroy', as: 'logout'
  # get 'works/index'
  # get 'works/new'

  resources :works
  resources :users


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
