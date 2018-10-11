Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/top_works', to: 'top_works#index'

  root 'top_works#index'

  resources :works, :users, :votes
end
