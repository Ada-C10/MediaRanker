Rails.application.routes.draw do
  # get 'home_controller/index'

  resources :works
  resources :users, only: [:index, :show, :new, :create]
end
