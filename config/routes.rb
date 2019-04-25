Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'works#welcome'

  resources :works do
    resources :votes, except:[:edit, :destroy]
  end
  post '/works/:id/upvote', to: 'works#upvote', as: 'upvote'

  resources :users, only:[:index, :new, :show] do
    resources :votes, except:[:edit, :destroy]
  end

  resources :sessions, only:[:new]
  post 'sessions/login', to: 'sessions#login', as: 'login'
  post 'sessions/logout', to: 'sessions#logout', as: 'logout'

end
