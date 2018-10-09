Rails.application.routes.draw do
  # Lets user login when they submit login form
post 'sessions/login', to: 'sessions#login', as: 'login'
# Brings up login form (get request)
get 'sessions/new', to: 'sessions#new', as: 'new_session'
# destroying the session
delete 'sessions/destroy', to: 'sessions#destroy', as: 'logout'

#TODO  Route for upvote method to upvote method in works controller 
  root 'welcome#index'

  resources :welcome, only:[:index] do
    resources :works, only:[:index]
    resources :users, only:[:index]
  end

  resources :works do
    resources :votes, only:[:index]
  end

# Don't need to delete users, instead we log them out
  resources :users, except:[:destroy] do
    resources :votes, only:[:index]
  end

end
