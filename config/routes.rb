Rails.application.routes.draw do
  get 'welcome/index'
  get 'votes/index'
  get 'welcome/index'

  root 'welcome#index'

  resources :work do
    resources :votes, only:[:index]
  end

  resources :user do
    resources :votes, only:[:index]
  end

end
