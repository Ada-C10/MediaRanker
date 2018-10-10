Rails.application.routes.draw do
  root 'works#home'
  resources :works

  resources :users, only:[:index, :show]

end
