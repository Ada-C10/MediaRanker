Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'pages#index'

  resources :works
  resources :users

  get '/pages', to: 'pages#index', as: 'pages'
end
