Rails.application.routes.draw do

  root to: 'works#main'

  get '/works/main', to: 'works#main', as: 'main_works'

  resources :users
  resources :works do
    resources :votes, only: [:index]
  end


end
