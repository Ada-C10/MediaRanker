Rails.application.routes.draw do
  root 'works#main'
  get 'works/:id/votes', to: 'works#upvote', as: 'work_upvote'
  resources :works
end
