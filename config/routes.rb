Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  get 'users/new'
  # get 'works/index'
  # get 'works/new'

  root 'works#index'
  
  resources :works

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
