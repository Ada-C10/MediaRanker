Rails.application.routes.draw do
  # get 'works/index'
  # get 'works/delete'
  # get 'works/edit'
  # get 'works/show'
  # get 'works/update'
  # get 'works/upvote'
  root 'pages#index'
  #get 'pages/index'
  post 'sessions/login', to: 'sessions#login', as: 'login'
  get 'sessions/login', to: 'sessions#new'
  delete 'sessions/destroy', to: 'sessions#destroy', as: 'logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :works
  delete '/works/:id', to: 'works#destroy', as: 'destroy'
end
