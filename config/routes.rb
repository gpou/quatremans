Nina::Application.routes.draw do

  match '/:locale' => 'static_pages#home'
  
  scope "(:locale)", :locale => /ca|es|en/ do
    root to: 'static_pages#home'
    resources :products

    match '/quisom',   to: 'static_pages#quisom'
    match '/contacte', to: 'static_pages#contacte'

    resources :sessions, only: [:new, :create, :destroy]
    match '/signin',  to: 'sessions#new'
    match '/signout', to: 'sessions#destroy', via: :delete
  end

end
