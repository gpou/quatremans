Nina::Application.routes.draw do

  #scope "(:locale)", :locale => /ca|es|en/ do
    root to: 'static_pages#home'
    resources :products

    match '/quisom',   to: 'static_pages#quisom'
    match '/contacte', to: 'static_pages#contacte'

    resources :sessions, only: [:new, :create, :destroy]
    match '/signin',  to: 'sessions#new'
    match '/signout', to: 'sessions#destroy', via: :delete
  #end

  #match '/:locale' => 'static_pages#home'
  ActionDispatch::Routing::Translator.translate_from_file('config/locales/routes.yml', { :keep_untranslated_routes => true })

end
