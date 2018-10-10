Rails.application.routes.draw do

  root 'works#main'

  resources :votes
  patch '/votes/:id/status', to: 'votes#status', as: 'vote_status'

  resources :users
<<<<<<< HEAD
  post 'user/login', to: 'user#login', as: 'login'

=======
  post 'users/login', to: 'users#login', as: 'login'
  
>>>>>>> viewsforweb
  resources :works


# get 'sessions/new to: session#new sessions
# get sessions destroy to sessions destory as logout
end
