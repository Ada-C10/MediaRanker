Rails.application.routes.draw do
  post 'sessions/login', to: 'sessions#login', as: 'login'
  get 'sessions/login', to: 'sessions#new', as: 'new_session'
  delete 'sessions/destroy', to: 'sessions#destroy', as: 'logout'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root 'works#index'

resources :works

resources :users, only: [:index, :show]

post '/works/:id/upvote', to: 'works#upvote', as: 'upvote'


end


#works  Prefix Verb   URI Pattern                                                                              Controller#Action
              #       login POST   /sessions/login(.:format)                                                                sessions#login
              # new_session GET    /sessions/login(.:format)                                                                sessions#new
              #      logout DELETE /sessions/destroy(.:format)                                                              sessions#destroy
              #        root GET    /                                                                                        works#index
              #       works GET    /works(.:format)                                                                         works#index
              #             POST   /works(.:format)                                                                         works#create
              #    new_work GET    /works/new(.:format)                                                                     works#new
              #   edit_work GET    /works/:id/edit(.:format)                                                                works#edit
              #        work GET    /works/:id(.:format)                                                                     works#show
              #             PATCH  /works/:id(.:format)                                                                     works#update
              #             PUT    /works/:id(.:format)                                                                     works#update
              #             DELETE /works/:id(.:format)                                                                     works#destroy
              #       users GET    /users(.:format)                                                                         users#index
              #        user GET    /users/:id(.:format)                                                                     users#show
