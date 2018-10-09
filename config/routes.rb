Rails.application.routes.draw do
  root 'works#top'

  resources :works

# Do we need a controller for votes? Good question Dan. I will think more about it. 
  # resources :votes

  resources :users
end
