Rails.application.routes.draw do
  root 'works#main'

  post 'sessions/login', to: 'sessions#login', as: 'login'
  get 'sessions/login', to: 'sessions#new'
  delete 'sessions/destroy', to: 'sessions#destroy', as: 'logout'

  get 'works/main', to: 'works#main'

  resources :works do
    resources :votes, only: [:create]
  end

  resources :users, except: [:new, :update, :edit, :destroy]

end
