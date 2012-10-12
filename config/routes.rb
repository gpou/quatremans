Nina::Application.routes.draw do

  resources :products

  root to: 'static_pages#home'

  match '/quisom',   to: 'static_pages#quisom'
  match '/contacte', to: 'static_pages#contacte'

  resources :sessions, only: [:new, :create, :destroy]
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
end
