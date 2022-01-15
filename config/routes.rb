Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/merchants/:id/dashboard', to: 'merchants#show'

  get '/merchants/:merchant_id/items', to: 'merchant_items#index'
  get '/merchants/:id/invoices', to: 'merchant_invoices#index'
  get '/merchants/:merchant_id/invoices/:id', to: 'merchant_invoices#show'
  patch '/merchants/:merchant_id/invoices/:invoice_id', to: 'merchant_invoices#update'


  get '/merchants/:id/bulk_discounts', to: 'bulk_discounts#index'
  get '/merchants/:id/bulk_discounts/new', to: 'bulk_discounts#new'
  get '/merchants/:id/bulk_discounts/:bulk_discount_id', to: 'bulk_discounts#show'
  post '/merchants/:merchant_id/bulk_discounts', to: 'bulk_discounts#create'
  delete '/merchants/:merchant_id/bulk_discounts/:bulk_discount_id', to: 'bulk_discounts#destroy'


  get '/merchants/:merchant_id/items/new', to: 'merchant_items#new'
  get '/merchants/:merchant_id/items/:item_id', to: 'merchant_items#show'
  get '/merchants/:merchant_id/items/:item_id/edit', to: 'merchant_items#edit'
  patch '/merchants/:merchant_id/items/:item_id', to: 'merchant_items#update'
  post '/merchants/:merchant_id/items', to: 'merchant_items#create'

  get '/admin', to: 'admin/base#index'
  get '/admin/merchants', to: 'admin/admin_merchants#index'
  get '/admin/invoices', to: 'admin/admin_invoices#index'
  get '/admin/invoices/:id', to: 'admin/admin_invoices#show'
  patch '/admin/invoices/:id', to: 'admin/admin_invoices#update'

  get '/admin/merchants/new', to: 'admin/admin_merchants#new'
  get '/admin/merchants/:id', to: 'admin/admin_merchants#show'
  get '/admin/merchants/:id/edit', to: 'admin/admin_merchants#edit'
  patch '/admin/merchants/:id', to: 'admin/admin_merchants#update'
  post '/admin/merchants', to: 'admin/admin_merchants#create'


end
