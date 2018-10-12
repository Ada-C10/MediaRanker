Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#index'

  get '/login', to: 'users#new', as: 'login'

  post '/login', to: 'users#login'

  post '/logout', to: 'users#logout', as: 'logout'

  resources :works

  resources :users

end
