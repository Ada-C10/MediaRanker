Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/home', to: 'home#index'
  root to: 'home#index'

  resources :works do
    resources :votes
  end

  resources :users, except:[:destroy]

  resources :sessions, only: [:new, :create]
  post '/sessions/logout', to: 'sessions#logout', as: 'logout'

end
