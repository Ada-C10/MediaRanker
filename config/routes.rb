Rails.application.routes.draw do

  root 'works#home'

  get 'sessions/login', to: 'sessions#new'
  post 'sessions/login', to: 'sessions#login', as: 'login'
  delete 'sessions/destroy', to: 'sessions#destroy', as: 'logout'

  resources :works
  resources :users
  resources :votes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

# TODO: exclude unused routes

# root 'trips#home'
# resources :trips, except: [:create, :new]
# resources :drivers
# resources :passengers, except: [:show] do
#   resources :trips, only: [:index, :show, :create]
# end
