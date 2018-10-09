Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :works, :users, :votes

  # QUESTION:  no delete for users? no delete for votes?
  # nested routes for works--votes?

  resources :sessions, only: [:new, :create, :delete]

  post '/sessions/logout', to: 'sessions#logout', as: 'logout'

end
