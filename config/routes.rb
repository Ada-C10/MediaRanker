Rails.application.routes.draw do
  root "main#index"
  get 'main/index', as: 'main'


  resources :works, only: [:index, :create, :new]



end
