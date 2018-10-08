Rails.application.routes.draw do

  root to: 'works#main'

  resources :users
  resources :works do
    resources :votes, only: [:index]
  end

  get '/works/main', to: 'works#main', as: 'main_works'

end
