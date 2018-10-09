Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'works#homepage'

  resources :votes

  resources :works do
    resources :votes, only: [:index, :create, :update]
  end


  resources :users do
    resources :votes, only: [:index, :create]
  end

  get '/home', to: 'works#homepage', as: 'home'


end
