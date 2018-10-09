Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  root 'welcome#index'

  resources :works
  resources :users, only: [:index, :show, :new]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
