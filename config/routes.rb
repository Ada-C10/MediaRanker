Rails.application.routes.draw do
  root 'works#home'

  post 'users/login', to: 'users#login', as: 'login'
  get 'users/login', to: 'users#new'
  delete 'users/destroy', to: 'users#destroy', as: 'logout'


  resources :users, only:[:index, :show]

  resources :works do
    resources :votes, only: [:create]
  end

end
