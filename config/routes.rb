Rails.application.routes.draw do
  get 'votes/index'
  resources :work do
    resources :votes, only:[:index]
  end

  resources :user do
    resources :votes, only:[:index]
  end

  # Unsure if I need a vote controller/vote routes as it's linked to the work/user views
end
