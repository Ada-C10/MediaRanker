Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

   root 'welcome#index'
   resources :works
   resources :users, except: [:edit, :update, :delete]
   #[:index, :new, :show, :create, :edit, :update, :delete]

end
