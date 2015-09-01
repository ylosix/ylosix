Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :customers, controllers: {
                           sessions: 'customers/sessions',
                           registrations: 'customers/registrations',
                           passwords: 'customers/passwords'
                       }


  # Admin routes
  ActiveAdmin.routes(self)
  get '/admin/products/:id/clone' => 'admin/products#new', :as => :admin_clone_product
  get '/admin/templates/:id/export' => 'admin/templates#export', :as => :admin_export_template
  get '/admin/templates/import' => 'admin/templates#import', :as => :admin_import_template
  get '/admin/shopping_orders/:id/invoice' => 'admin/shopping_orders#invoice', :as => :admin_invoice_shopping_order

  # Frontend
  resource :categories, only: [] do
    get '/' => 'categories#index'
    get '/:slug' => 'categories#show', as: :show_slug
    get '/:id/show' => 'categories#show', as: :show_id
    get '/:category_slug/products/:slug' => 'products#show', as: :show_product_slug
    match '/:slug/tag/*slug_tags' => 'categories#tags', as: :tags, via: [:get]
  end

  match '/tag/*slug_tags' => 'categories#tags', as: :tags, via: [:get]

  resource :products, only: [] do
    get '/:slug' => 'products#show', as: :show_slug
    get '/:id/show' => 'products#show', as: :show_id
    get '/:id/add_to_shopping_cart' => 'products#add_to_shopping_cart', as: :add_to_shopping_cart
    get '/:id/delete_from_shopping_cart' => 'products#delete_from_shopping_cart', as: :delete_from_shopping_cart
  end

  resource :searches, only: [] do
    post '/' => 'searches#index'
  end

  resource :customers, only: [] do
    get '/show' => 'customers#show'
    get '/orders' => 'customers#orders'
    get '/orders/:id/invoice' => 'customers#invoice', as: :orders_invoice

    resources :addresses
    resource :shopping_carts, only: [] do
      get '/' => 'shopping_carts#show'
      post '/:product_id/update' => 'shopping_carts#update', as: :update
    end

    resource :shopping_orders, only: [] do
      get '/shipping_method' => 'shopping_orders#shipping_method'
      get '/:type/addresses' => 'shopping_orders#addresses', as: :addresses
      get '/:type/:id/save_address' => 'shopping_orders#save_address', as: :save_address

      post '/save_carrier' => 'shopping_orders#save_carrier'
      get '/checkout' => 'shopping_orders#checkout'
      get '/finalize' => 'shopping_orders#finalize'
    end
  end

  get '/locale/:locale' => 'application#change_locale', :as => 'change_locale'

  # From https://www.airpair.com/ruby-on-rails/posts/building-a-restful-api-in-a-rails-application
  scope '/api' do
    scope '/v1' do
      scope '/data_forms' do
        post '/' => 'api/data_forms#create'
      end
    end
  end

  # You can have the root of your site routed with "root"
  root 'home#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
