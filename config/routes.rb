Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "homepage#index", as: 'home'

  resources :users, :works, :votes

  post '/works/:work_id/votes', to: 'votes#create', as: 'create_work_vote'

  resources :sessions, only: [:new, :create]

  post 'sessions/logout', to: 'sessions#logout', as: 'logout'

end
