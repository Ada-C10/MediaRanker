Rails.application.routes.draw do

  resources :votes

  resources :users
  post 'user/login', to: 'user#login', as: 'login'

  resources :works


# get 'sessions/new to: session#new sessions
# get sessions destroy to sessions destory as logout
end
