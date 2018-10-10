Rails.application.routes.draw do
  post 'sessions/login', to: 'sessions#login', as: 'login'
  get 'sessions/login', to: 'sessions#new'
  delete 'sessions/destroy', to: 'sessions#destroy', as: 'logout'

  root 'works#main'

  resources :works
  resources :users, except: [:update, :edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
