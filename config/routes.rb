Rails.application.routes.draw do
  get 'welcome/index'
  get 'votes/index'
  get 'welcome/index'

  root 'welcome#index'

  resources :welcome, only:[:index] do
    resources :works, only:[:index]
    resources :users, only:[:index]
  end

  resources :works do
    resources :votes, only:[:index]
  end

  resources :users do
    resources :votes, only:[:index]
  end

end
