Nina::Application.routes.draw do

  root to: 'static_pages#home'

  match '/quisom',   to: 'static_pages#quisom'
  match '/contacte', to: 'static_pages#contacte'

end
