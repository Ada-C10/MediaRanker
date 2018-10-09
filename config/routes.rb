Rails.application.routes.draw do
  # get 'works/index'
  # get 'works/new'

  root 'works#index'
  
  resources :works

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
