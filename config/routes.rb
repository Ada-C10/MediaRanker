Rails.application.routes.draw do
  root "main#index"
  get 'main/index', as: 'main'


  resources :works



end
