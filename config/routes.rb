Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :users, only: [:index, :show, :create]

  resources :works do
    resources :votes, only: [:create]
  end

  get '/login', to: 'sessions#new', as: 'login_form'
  post '/login', to: 'sesstions#create' as: 'login'
  delete '/login', to: 'sessions#destroy', as: 'logout'

end
