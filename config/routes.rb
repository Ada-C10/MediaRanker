Rails.application.routes.draw do

  root 'works#main'

  resources :works
  resources :users, except: [:update, :edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
