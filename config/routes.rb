Rails.application.routes.draw do
  get 'works/index'
  get 'works/show'
  get 'works/new'
  get 'works/create'
  get 'works/edit'
  get 'works/update'
  get 'works/destroy'
  get 'votes/new'
  get 'votes/edit'
  get 'users/index'
  get 'users/show'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
