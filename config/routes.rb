Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "pages#show", page: "home"
  resources :media
  resources :users, only: [:index, :new]
  post '/media/:id/upvote', to: 'users#upvote', as: :upvote
  get "/pages/:page" => "pages#show"
end
