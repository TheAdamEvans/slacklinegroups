Rails.application.routes.draw do
  get 'map/index'
  get 'map/pointclouds'
  get 'map/cover'
  get 'about', to: 'about#index'

  
  post 'groups/new', to: 'groups#create'
  resources :groups
  resources :admin

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'map#index'
end
