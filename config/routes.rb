Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :customers, controllers: {
                           sessions: 'customers/sessions',
                           registrations: 'customers/registrations'
                       }


  # Admin routes
  ActiveAdmin.routes(self)
  get '/admin/products/:id/clone' => 'admin/products#new', :as => :admin_clone_product
  get '/admin/templates/:id/export' => 'admin/templates#export', :as => :admin_export_template
  get '/admin/templates/import' => 'admin/templates#import', :as => :admin_import_template

  # Frontend
  resource :categories, only: [] do
    get '/' => 'categories#index'
    get '/:slug' => 'categories#show', as: :show_slug
    get '/:id/show' => 'categories#show', as: :show_id
  end

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

    resource :shopping_carts, only: [] do
      get '/' => 'shopping_carts#show'
      get '/:product_id/update/:quantity' => 'shopping_carts#update', as: :update
    end

    resource :shopping_orders, only: [] do
      get '/' => 'shopping_orders#show'
      get '/finalize' => 'shopping_orders#finalize'
    end
  end

  get '/locale/:locale' => 'application#change_locale', :as => 'change_locale'
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
