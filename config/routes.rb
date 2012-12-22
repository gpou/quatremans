Quatremans::Application.routes.draw do

  resources :fotos

  resources :personalitzacions

  resources :personalitzacios

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root to: 'static_pages#home'

  match '/quisom',   to: 'static_pages#quisom'
  match '/contacte', to: 'static_pages#contacte'
  match '/condicionscompra', to: 'static_pages#condicionscompra'

  resources :coleccions, :only => [:index, :show] do
    resources :productes, :only => [:index, :show]
  end
  resources :productes, :only => [:index]

  resource :cart, :only => [] do
    collection do
      get :edit_cart, :as => "edit"
      put :update_cart, :as => "update"
      get :nina
      get :shipment_address_cart, :as => "shipment_address"
      post :save_shipment_address_cart, :as => "save_shipment_address"
      get :invoice_address_cart, :as => "invoice_address"
      post :save_invoice_address_cart, :as => "save_invoice_address"
      get :validation_cart, :as => "validation"
    end
    resources :cart_items, :only => [:index, :edit, :update, :destroy], :as => "items", :controller => "carts"
  end

  match ':id' => 'coleccions#show', :as => :coleccio
  match ':coleccio_id/:id' => 'productes#show', :as => :producte

  #match '/:locale' => 'static_pages#home'
  ActionDispatch::Routing::Translator.translate_from_file('config/locales/routes.yml', { :keep_untranslated_routes => true })

  
end
