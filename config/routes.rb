Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

   root 'welcome#index'
   resources :works
   resources :users, except: [:new, :edit, :update, :delete]
   get '/signup', to: 'users#new'

   get '/login', to: 'sessions#new'
   post '/login', to: 'sessions#create'
   delete '/logout', to: 'sessions#destroy'

   resources :works do
     resources :votes, only: :create
   end
   #[:index, :new, :show, :create, :edit, :update, :delete]

end
