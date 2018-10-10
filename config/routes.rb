Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepage#index'
  resources :works, :users, :votes

  resources :sessions, only: [:new, :create]
  post '/sessions/logout', to: 'sessions#logout', as: 'logout'
end
