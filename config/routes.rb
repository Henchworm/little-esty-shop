Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/merchants/:id/dashboard', to: 'merchants#show'

   get '/merchants/:merchant_id/items', to: 'merchant_items#index'
   get '/merchants/:id/invoices', to: 'merchant_invoices#index'
   get '/merchants/:merchant_id/invoices/:id', to: 'merchant_invoices#show'

  get '/merchants/:merchant_id/items/new', to: 'merchant_items#new'
  get '/merchants/:merchant_id/items/:item_id', to: 'merchant_items#show'
  get '/merchants/:merchant_id/items/:item_id/edit', to: 'merchant_items#edit'
  patch '/merchants/:merchant_id/items/:item_id', to: 'merchant_items#update'
  post '/merchants/:merchant_id/items', to: 'merchant_items#create'

  get '/admin', to: 'admin/base#index'

end
