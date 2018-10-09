Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :media
  resources :users, only: [:index]
  post "/media/:id/upvote", to: "users#upvote", as: :upvote
end
