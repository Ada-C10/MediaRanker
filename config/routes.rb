Rails.application.routes.draw do

  root 'works#main'

  resources :votes

  resources :users

  resources :works

end
