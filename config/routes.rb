Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'homes#index'
  get '/homes', to: 'homes#index'
  resources :users, except: [:update]
  resources :works

end
