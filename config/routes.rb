Rails.application.routes.draw do
  resources :works
  root to: 'pages#home'
  get 'votes/index'
  get 'works/index'
  get 'works/show'
  get 'users/index'
  get 'users/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
