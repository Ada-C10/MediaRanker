Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :works, :users, :votes

  # QUESTION:  no delete for users? no delete for votes?

end
