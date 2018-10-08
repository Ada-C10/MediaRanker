Rails.application.routes.draw do
  root 'pages#home'

  resources :works
  resources :users
end
