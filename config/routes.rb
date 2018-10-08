Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
resources :works

end


#works GET    /works(.:format)                                                                         works#index
                #           POST   /works(.:format)                                                                         works#create
                #  new_work GET    /works/new(.:format)                                                                     works#new
                # edit_work GET    /works/:id/edit(.:format)                                                                works#edit
                #      work GET    /works/:id(.:format)                                                                     works#show
                #           PATCH  /works/:id(.:format)                                                                     works#update
                #           PUT    /works/:id(.:format)                                                                     works#update
                #           DELETE /works/:id(.:format)                                                                     works#destroy
