# == Route Map
#
#                                      Prefix Verb       URI Pattern                                               Controller#Action
#                                    ckeditor            /ckeditor                                                 Ckeditor::Engine
#                      new_admin_user_session GET        /admin/login(.:format)                                    active_admin/devise/sessions#new
#                          admin_user_session POST       /admin/login(.:format)                                    active_admin/devise/sessions#create
#                  destroy_admin_user_session DELETE|GET /admin/logout(.:format)                                   active_admin/devise/sessions#destroy
#                         admin_user_password POST       /admin/password(.:format)                                 active_admin/devise/passwords#create
#                     new_admin_user_password GET        /admin/password/new(.:format)                             active_admin/devise/passwords#new
#                    edit_admin_user_password GET        /admin/password/edit(.:format)                            active_admin/devise/passwords#edit
#                                             PATCH      /admin/password(.:format)                                 active_admin/devise/passwords#update
#                                             PUT        /admin/password(.:format)                                 active_admin/devise/passwords#update
#                        new_customer_session GET        /customers/sign_in(.:format)                              customers/sessions#new
#                            customer_session POST       /customers/sign_in(.:format)                              customers/sessions#create
#                    destroy_customer_session DELETE     /customers/sign_out(.:format)                             customers/sessions#destroy
#                           customer_password POST       /customers/password(.:format)                             customers/passwords#create
#                       new_customer_password GET        /customers/password/new(.:format)                         customers/passwords#new
#                      edit_customer_password GET        /customers/password/edit(.:format)                        customers/passwords#edit
#                                             PATCH      /customers/password(.:format)                             customers/passwords#update
#                                             PUT        /customers/password(.:format)                             customers/passwords#update
#                cancel_customer_registration GET        /customers/cancel(.:format)                               customers/registrations#cancel
#                       customer_registration POST       /customers(.:format)                                      customers/registrations#create
#                   new_customer_registration GET        /customers/sign_up(.:format)                              customers/registrations#new
#                  edit_customer_registration GET        /customers/edit(.:format)                                 customers/registrations#edit
#                                             PATCH      /customers(.:format)                                      customers/registrations#update
#                                             PUT        /customers(.:format)                                      customers/registrations#update
#                                             DELETE     /customers(.:format)                                      customers/registrations#destroy
#                                  admin_root GET        /admin(.:format)                                          admin/dashboard#index
#             batch_action_admin_action_forms POST       /admin/action_forms/batch_action(.:format)                admin/action_forms#batch_action
#                          admin_action_forms GET        /admin/action_forms(.:format)                             admin/action_forms#index
#                                             POST       /admin/action_forms(.:format)                             admin/action_forms#create
#                       new_admin_action_form GET        /admin/action_forms/new(.:format)                         admin/action_forms#new
#                      edit_admin_action_form GET        /admin/action_forms/:id/edit(.:format)                    admin/action_forms#edit
#                           admin_action_form GET        /admin/action_forms/:id(.:format)                         admin/action_forms#show
#                                             PATCH      /admin/action_forms/:id(.:format)                         admin/action_forms#update
#                                             PUT        /admin/action_forms/:id(.:format)                         admin/action_forms#update
#                                             DELETE     /admin/action_forms/:id(.:format)                         admin/action_forms#destroy
#              batch_action_admin_admin_users POST       /admin/admin_users/batch_action(.:format)                 admin/admin_users#batch_action
#                           admin_admin_users GET        /admin/admin_users(.:format)                              admin/admin_users#index
#                                             POST       /admin/admin_users(.:format)                              admin/admin_users#create
#                        new_admin_admin_user GET        /admin/admin_users/new(.:format)                          admin/admin_users#new
#                       edit_admin_admin_user GET        /admin/admin_users/:id/edit(.:format)                     admin/admin_users#edit
#                            admin_admin_user GET        /admin/admin_users/:id(.:format)                          admin/admin_users#show
#                                             PATCH      /admin/admin_users/:id(.:format)                          admin/admin_users#update
#                                             PUT        /admin/admin_users/:id(.:format)                          admin/admin_users#update
#                                             DELETE     /admin/admin_users/:id(.:format)                          admin/admin_users#destroy
#                 batch_action_admin_carriers POST       /admin/carriers/batch_action(.:format)                    admin/carriers#batch_action
#                              admin_carriers GET        /admin/carriers(.:format)                                 admin/carriers#index
#                                             POST       /admin/carriers(.:format)                                 admin/carriers#create
#                           new_admin_carrier GET        /admin/carriers/new(.:format)                             admin/carriers#new
#                          edit_admin_carrier GET        /admin/carriers/:id/edit(.:format)                        admin/carriers#edit
#                               admin_carrier GET        /admin/carriers/:id(.:format)                             admin/carriers#show
#                                             PATCH      /admin/carriers/:id(.:format)                             admin/carriers#update
#                                             PUT        /admin/carriers/:id(.:format)                             admin/carriers#update
#                                             DELETE     /admin/carriers/:id(.:format)                             admin/carriers#destroy
#               batch_action_admin_categories POST       /admin/categories/batch_action(.:format)                  admin/categories#batch_action
#                            admin_categories GET        /admin/categories(.:format)                               admin/categories#index
#                                             POST       /admin/categories(.:format)                               admin/categories#create
#                          new_admin_category GET        /admin/categories/new(.:format)                           admin/categories#new
#                         edit_admin_category GET        /admin/categories/:id/edit(.:format)                      admin/categories#edit
#                              admin_category GET        /admin/categories/:id(.:format)                           admin/categories#show
#                                             PATCH      /admin/categories/:id(.:format)                           admin/categories#update
#                                             PUT        /admin/categories/:id(.:format)                           admin/categories#update
#                                             DELETE     /admin/categories/:id(.:format)                           admin/categories#destroy
#                batch_action_admin_commerces POST       /admin/commerces/batch_action(.:format)                   admin/commerces#batch_action
#                             admin_commerces GET        /admin/commerces(.:format)                                admin/commerces#index
#                                             POST       /admin/commerces(.:format)                                admin/commerces#create
#                          new_admin_commerce GET        /admin/commerces/new(.:format)                            admin/commerces#new
#                         edit_admin_commerce GET        /admin/commerces/:id/edit(.:format)                       admin/commerces#edit
#                              admin_commerce GET        /admin/commerces/:id(.:format)                            admin/commerces#show
#                                             PATCH      /admin/commerces/:id(.:format)                            admin/commerces#update
#                                             PUT        /admin/commerces/:id(.:format)                            admin/commerces#update
#                                             DELETE     /admin/commerces/:id(.:format)                            admin/commerces#destroy
#                batch_action_admin_countries POST       /admin/countries/batch_action(.:format)                   admin/countries#batch_action
#                             admin_countries GET        /admin/countries(.:format)                                admin/countries#index
#                                             POST       /admin/countries(.:format)                                admin/countries#create
#                           new_admin_country GET        /admin/countries/new(.:format)                            admin/countries#new
#                          edit_admin_country GET        /admin/countries/:id/edit(.:format)                       admin/countries#edit
#                               admin_country GET        /admin/countries/:id(.:format)                            admin/countries#show
#                                             PATCH      /admin/countries/:id(.:format)                            admin/countries#update
#                                             PUT        /admin/countries/:id(.:format)                            admin/countries#update
#                                             DELETE     /admin/countries/:id(.:format)                            admin/countries#destroy
#                batch_action_admin_customers POST       /admin/customers/batch_action(.:format)                   admin/customers#batch_action
#                             admin_customers GET        /admin/customers(.:format)                                admin/customers#index
#                                             POST       /admin/customers(.:format)                                admin/customers#create
#                          new_admin_customer GET        /admin/customers/new(.:format)                            admin/customers#new
#                         edit_admin_customer GET        /admin/customers/:id/edit(.:format)                       admin/customers#edit
#                              admin_customer GET        /admin/customers/:id(.:format)                            admin/customers#show
#                                             PATCH      /admin/customers/:id(.:format)                            admin/customers#update
#                                             PUT        /admin/customers/:id(.:format)                            admin/customers#update
#                                             DELETE     /admin/customers/:id(.:format)                            admin/customers#destroy
#       batch_action_admin_customer_addresses POST       /admin/customer_addresses/batch_action(.:format)          admin/customer_addresses#batch_action
#                    admin_customer_addresses GET        /admin/customer_addresses(.:format)                       admin/customer_addresses#index
#                                             POST       /admin/customer_addresses(.:format)                       admin/customer_addresses#create
#                  new_admin_customer_address GET        /admin/customer_addresses/new(.:format)                   admin/customer_addresses#new
#                 edit_admin_customer_address GET        /admin/customer_addresses/:id/edit(.:format)              admin/customer_addresses#edit
#                      admin_customer_address GET        /admin/customer_addresses/:id(.:format)                   admin/customer_addresses#show
#                                             PATCH      /admin/customer_addresses/:id(.:format)                   admin/customer_addresses#update
#                                             PUT        /admin/customer_addresses/:id(.:format)                   admin/customer_addresses#update
#                                             DELETE     /admin/customer_addresses/:id(.:format)                   admin/customer_addresses#destroy
#                             admin_dashboard GET        /admin/dashboard(.:format)                                admin/dashboard#index
#               batch_action_admin_data_forms POST       /admin/data_forms/batch_action(.:format)                  admin/data_forms#batch_action
#                            admin_data_forms GET        /admin/data_forms(.:format)                               admin/data_forms#index
#                                             POST       /admin/data_forms(.:format)                               admin/data_forms#create
#                        edit_admin_data_form GET        /admin/data_forms/:id/edit(.:format)                      admin/data_forms#edit
#                             admin_data_form GET        /admin/data_forms/:id(.:format)                           admin/data_forms#show
#                                             PATCH      /admin/data_forms/:id(.:format)                           admin/data_forms#update
#                                             PUT        /admin/data_forms/:id(.:format)                           admin/data_forms#update
#                                             DELETE     /admin/data_forms/:id(.:format)                           admin/data_forms#destroy
#             batch_action_admin_design_forms POST       /admin/design_forms/batch_action(.:format)                admin/design_forms#batch_action
#                          admin_design_forms GET        /admin/design_forms(.:format)                             admin/design_forms#index
#                                             POST       /admin/design_forms(.:format)                             admin/design_forms#create
#                       new_admin_design_form GET        /admin/design_forms/new(.:format)                         admin/design_forms#new
#                      edit_admin_design_form GET        /admin/design_forms/:id/edit(.:format)                    admin/design_forms#edit
#                           admin_design_form GET        /admin/design_forms/:id(.:format)                         admin/design_forms#show
#                                             PATCH      /admin/design_forms/:id(.:format)                         admin/design_forms#update
#                                             PUT        /admin/design_forms/:id(.:format)                         admin/design_forms#update
#                                             DELETE     /admin/design_forms/:id(.:format)                         admin/design_forms#destroy
#                 batch_action_admin_features POST       /admin/features/batch_action(.:format)                    admin/features#batch_action
#                              admin_features GET        /admin/features(.:format)                                 admin/features#index
#                                             POST       /admin/features(.:format)                                 admin/features#create
#                           new_admin_feature GET        /admin/features/new(.:format)                             admin/features#new
#                          edit_admin_feature GET        /admin/features/:id/edit(.:format)                        admin/features#edit
#                               admin_feature GET        /admin/features/:id(.:format)                             admin/features#show
#                                             PATCH      /admin/features/:id(.:format)                             admin/features#update
#                                             PUT        /admin/features/:id(.:format)                             admin/features#update
#                                             DELETE     /admin/features/:id(.:format)                             admin/features#destroy
#                batch_action_admin_languages POST       /admin/languages/batch_action(.:format)                   admin/languages#batch_action
#                             admin_languages GET        /admin/languages(.:format)                                admin/languages#index
#                                             POST       /admin/languages(.:format)                                admin/languages#create
#                          new_admin_language GET        /admin/languages/new(.:format)                            admin/languages#new
#                         edit_admin_language GET        /admin/languages/:id/edit(.:format)                       admin/languages#edit
#                              admin_language GET        /admin/languages/:id(.:format)                            admin/languages#show
#                                             PATCH      /admin/languages/:id(.:format)                            admin/languages#update
#                                             PUT        /admin/languages/:id(.:format)                            admin/languages#update
#                                             DELETE     /admin/languages/:id(.:format)                            admin/languages#destroy
#                    batch_action_admin_links POST       /admin/links/batch_action(.:format)                       admin/links#batch_action
#                                 admin_links GET        /admin/links(.:format)                                    admin/links#index
#                                             POST       /admin/links(.:format)                                    admin/links#create
#                              new_admin_link GET        /admin/links/new(.:format)                                admin/links#new
#                                  admin_link GET        /admin/links/:id(.:format)                                admin/links#show
#                                             PATCH      /admin/links/:id(.:format)                                admin/links#update
#                                             PUT        /admin/links/:id(.:format)                                admin/links#update
#                 batch_action_admin_products POST       /admin/products/batch_action(.:format)                    admin/products#batch_action
#                              admin_products GET        /admin/products(.:format)                                 admin/products#index
#                                             POST       /admin/products(.:format)                                 admin/products#create
#                           new_admin_product GET        /admin/products/new(.:format)                             admin/products#new
#                          edit_admin_product GET        /admin/products/:id/edit(.:format)                        admin/products#edit
#                               admin_product GET        /admin/products/:id(.:format)                             admin/products#show
#                                             PATCH      /admin/products/:id(.:format)                             admin/products#update
#                                             PUT        /admin/products/:id(.:format)                             admin/products#update
#                                             DELETE     /admin/products/:id(.:format)                             admin/products#destroy
#           batch_action_admin_shopping_carts POST       /admin/shopping_carts/batch_action(.:format)              admin/shopping_carts#batch_action
#                        admin_shopping_carts GET        /admin/shopping_carts(.:format)                           admin/shopping_carts#index
#                                             POST       /admin/shopping_carts(.:format)                           admin/shopping_carts#create
#                     new_admin_shopping_cart GET        /admin/shopping_carts/new(.:format)                       admin/shopping_carts#new
#                    edit_admin_shopping_cart GET        /admin/shopping_carts/:id/edit(.:format)                  admin/shopping_carts#edit
#                         admin_shopping_cart GET        /admin/shopping_carts/:id(.:format)                       admin/shopping_carts#show
#                                             PATCH      /admin/shopping_carts/:id(.:format)                       admin/shopping_carts#update
#                                             PUT        /admin/shopping_carts/:id(.:format)                       admin/shopping_carts#update
#                                             DELETE     /admin/shopping_carts/:id(.:format)                       admin/shopping_carts#destroy
#          batch_action_admin_shopping_orders POST       /admin/shopping_orders/batch_action(.:format)             admin/shopping_orders#batch_action
#                       admin_shopping_orders GET        /admin/shopping_orders(.:format)                          admin/shopping_orders#index
#                                             POST       /admin/shopping_orders(.:format)                          admin/shopping_orders#create
#                    new_admin_shopping_order GET        /admin/shopping_orders/new(.:format)                      admin/shopping_orders#new
#                   edit_admin_shopping_order GET        /admin/shopping_orders/:id/edit(.:format)                 admin/shopping_orders#edit
#                        admin_shopping_order GET        /admin/shopping_orders/:id(.:format)                      admin/shopping_orders#show
#                                             PATCH      /admin/shopping_orders/:id(.:format)                      admin/shopping_orders#update
#                                             PUT        /admin/shopping_orders/:id(.:format)                      admin/shopping_orders#update
#                                             DELETE     /admin/shopping_orders/:id(.:format)                      admin/shopping_orders#destroy
# batch_action_admin_shopping_orders_statuses POST       /admin/shopping_orders_statuses/batch_action(.:format)    admin/shopping_orders_statuses#batch_action
#              admin_shopping_orders_statuses GET        /admin/shopping_orders_statuses(.:format)                 admin/shopping_orders_statuses#index
#                                             POST       /admin/shopping_orders_statuses(.:format)                 admin/shopping_orders_statuses#create
#            new_admin_shopping_orders_status GET        /admin/shopping_orders_statuses/new(.:format)             admin/shopping_orders_statuses#new
#           edit_admin_shopping_orders_status GET        /admin/shopping_orders_statuses/:id/edit(.:format)        admin/shopping_orders_statuses#edit
#                admin_shopping_orders_status GET        /admin/shopping_orders_statuses/:id(.:format)             admin/shopping_orders_statuses#show
#                                             PATCH      /admin/shopping_orders_statuses/:id(.:format)             admin/shopping_orders_statuses#update
#                                             PUT        /admin/shopping_orders_statuses/:id(.:format)             admin/shopping_orders_statuses#update
#                                             DELETE     /admin/shopping_orders_statuses/:id(.:format)             admin/shopping_orders_statuses#destroy
#                 batch_action_admin_snippets POST       /admin/snippets/batch_action(.:format)                    admin/snippets#batch_action
#                              admin_snippets GET        /admin/snippets(.:format)                                 admin/snippets#index
#                                             POST       /admin/snippets(.:format)                                 admin/snippets#create
#                           new_admin_snippet GET        /admin/snippets/new(.:format)                             admin/snippets#new
#                          edit_admin_snippet GET        /admin/snippets/:id/edit(.:format)                        admin/snippets#edit
#                               admin_snippet GET        /admin/snippets/:id(.:format)                             admin/snippets#show
#                                             PATCH      /admin/snippets/:id(.:format)                             admin/snippets#update
#                                             PUT        /admin/snippets/:id(.:format)                             admin/snippets#update
#                                             DELETE     /admin/snippets/:id(.:format)                             admin/snippets#destroy
#                     batch_action_admin_tags POST       /admin/tags/batch_action(.:format)                        admin/tags#batch_action
#                                  admin_tags GET        /admin/tags(.:format)                                     admin/tags#index
#                                             POST       /admin/tags(.:format)                                     admin/tags#create
#                               new_admin_tag GET        /admin/tags/new(.:format)                                 admin/tags#new
#                              edit_admin_tag GET        /admin/tags/:id/edit(.:format)                            admin/tags#edit
#                                   admin_tag GET        /admin/tags/:id(.:format)                                 admin/tags#show
#                                             PATCH      /admin/tags/:id(.:format)                                 admin/tags#update
#                                             PUT        /admin/tags/:id(.:format)                                 admin/tags#update
#                                             DELETE     /admin/tags/:id(.:format)                                 admin/tags#destroy
#              batch_action_admin_tags_groups POST       /admin/tags_groups/batch_action(.:format)                 admin/tags_groups#batch_action
#                           admin_tags_groups GET        /admin/tags_groups(.:format)                              admin/tags_groups#index
#                                             POST       /admin/tags_groups(.:format)                              admin/tags_groups#create
#                        new_admin_tags_group GET        /admin/tags_groups/new(.:format)                          admin/tags_groups#new
#                       edit_admin_tags_group GET        /admin/tags_groups/:id/edit(.:format)                     admin/tags_groups#edit
#                            admin_tags_group GET        /admin/tags_groups/:id(.:format)                          admin/tags_groups#show
#                                             PATCH      /admin/tags_groups/:id(.:format)                          admin/tags_groups#update
#                                             PUT        /admin/tags_groups/:id(.:format)                          admin/tags_groups#update
#                                             DELETE     /admin/tags_groups/:id(.:format)                          admin/tags_groups#destroy
#                    batch_action_admin_taxes POST       /admin/taxes/batch_action(.:format)                       admin/taxes#batch_action
#                                 admin_taxes GET        /admin/taxes(.:format)                                    admin/taxes#index
#                                             POST       /admin/taxes(.:format)                                    admin/taxes#create
#                               new_admin_tax GET        /admin/taxes/new(.:format)                                admin/taxes#new
#                              edit_admin_tax GET        /admin/taxes/:id/edit(.:format)                           admin/taxes#edit
#                                   admin_tax GET        /admin/taxes/:id(.:format)                                admin/taxes#show
#                                             PATCH      /admin/taxes/:id(.:format)                                admin/taxes#update
#                                             PUT        /admin/taxes/:id(.:format)                                admin/taxes#update
#                                             DELETE     /admin/taxes/:id(.:format)                                admin/taxes#destroy
#                      import_admin_templates GET        /admin/templates/import(.:format)                         admin/templates#import
#                                             POST       /admin/templates/import(.:format)                         admin/templates#import
#                batch_action_admin_templates POST       /admin/templates/batch_action(.:format)                   admin/templates#batch_action
#                             admin_templates GET        /admin/templates(.:format)                                admin/templates#index
#                                             POST       /admin/templates(.:format)                                admin/templates#create
#                         edit_admin_template GET        /admin/templates/:id/edit(.:format)                       admin/templates#edit
#                              admin_template GET        /admin/templates/:id(.:format)                            admin/templates#show
#                                             PATCH      /admin/templates/:id(.:format)                            admin/templates#update
#                                             PUT        /admin/templates/:id(.:format)                            admin/templates#update
#                                             DELETE     /admin/templates/:id(.:format)                            admin/templates#destroy
#                    batch_action_admin_zones POST       /admin/zones/batch_action(.:format)                       admin/zones#batch_action
#                                 admin_zones GET        /admin/zones(.:format)                                    admin/zones#index
#                                             POST       /admin/zones(.:format)                                    admin/zones#create
#                              new_admin_zone GET        /admin/zones/new(.:format)                                admin/zones#new
#                             edit_admin_zone GET        /admin/zones/:id/edit(.:format)                           admin/zones#edit
#                                  admin_zone GET        /admin/zones/:id(.:format)                                admin/zones#show
#                                             PATCH      /admin/zones/:id(.:format)                                admin/zones#update
#                                             PUT        /admin/zones/:id(.:format)                                admin/zones#update
#                                             DELETE     /admin/zones/:id(.:format)                                admin/zones#destroy
#                        admin_admin_comments GET        /admin/admin_comments(.:format)                           admin/admin_comments#index
#                                             POST       /admin/admin_comments(.:format)                           admin/admin_comments#create
#                         admin_admin_comment GET        /admin/admin_comments/:id(.:format)                       admin/admin_comments#show
#                                             DELETE     /admin/admin_comments/:id(.:format)                       admin/admin_comments#destroy
#                         admin_clone_product GET        /admin/products/:id/clone(.:format)                       admin/products#new
#                       admin_export_template GET        /admin/templates/:id/export(.:format)                     admin/templates#export
#                       admin_import_template GET        /admin/templates/import(.:format)                         admin/templates#import
#                admin_invoice_shopping_order GET        /admin/shopping_orders/:id/invoice(.:format)              admin/shopping_orders#invoice
#                                    category GET        /categories/:category_id(.:format)                        categories#show
#                  category_show_product_slug GET        /categories/:category_id/products/:product_id(.:format)   products#show
#                               category_tags GET        /categories/:category_id/tags/*slug_tags(.:format)        categories#tags
#                                  categories GET        /categories(.:format)                                     categories#index
#                                        tags GET        /tags/*slug_tags(.:format)                                categories#tags
#                                     product GET        /products/:product_id(.:format)                           products#show
#                product_add_to_shopping_cart GET        /products/:product_id/add_to_shopping_cart(.:format)      products#add_to_shopping_cart
#           product_delete_from_shopping_cart GET        /products/:product_id/delete_from_shopping_cart(.:format) products#delete_from_shopping_cart
#                                    products GET        /products(.:format)                                       products#index
#                                    searches POST       /searches(.:format)                                       searches#index
#                         show_shopping_carts GET        /shopping_carts/show(.:format)                            shopping_carts#show
#                        clear_shopping_carts GET        /shopping_carts/clear(.:format)                           shopping_carts#clear
#                       update_shopping_carts POST       /shopping_carts/:product_id/update(.:format)              shopping_carts#update
#                         save_shopping_carts POST       /shopping_carts/save(.:format)                            shopping_carts#save
#                              show_customers GET        /customers/show(.:format)                                 customers#show
#                            orders_customers GET        /customers/orders(.:format)                               customers#orders
#                    orders_invoice_customers GET        /customers/orders/:id/invoice(.:format)                   customers#invoice
#                         customers_addresses GET        /customers/addresses(.:format)                            addresses#index
#                                             POST       /customers/addresses(.:format)                            addresses#create
#                       new_customers_address GET        /customers/addresses/new(.:format)                        addresses#new
#                      edit_customers_address GET        /customers/addresses/:id/edit(.:format)                   addresses#edit
#                           customers_address GET        /customers/addresses/:id(.:format)                        addresses#show
#                                             PATCH      /customers/addresses/:id(.:format)                        addresses#update
#                                             PUT        /customers/addresses/:id(.:format)                        addresses#update
#                                             DELETE     /customers/addresses/:id(.:format)                        addresses#destroy
#   shipping_method_customers_shopping_orders GET        /customers/shopping_orders/shipping_method(.:format)      shopping_orders#shipping_method
#         addresses_customers_shopping_orders GET        /customers/shopping_orders/:type/addresses(.:format)      shopping_orders#addresses
#      save_address_customers_shopping_orders POST       /customers/shopping_orders/:id/save_address(.:format)     shopping_orders#save_address
#      save_carrier_customers_shopping_orders POST       /customers/shopping_orders/save_carrier(.:format)         shopping_orders#save_carrier
#          checkout_customers_shopping_orders GET        /customers/shopping_orders/checkout(.:format)             shopping_orders#checkout
#          finalize_customers_shopping_orders POST       /customers/shopping_orders/finalize(.:format)             shopping_orders#finalize
#                               change_locale GET        /locale/:locale(.:format)                                 application#change_locale
#                                             POST       /api/v1/data_forms(.:format)                              api/data_forms#create
#                                             GET        /api/v1/categories/:category_id/products(.:format)        api/categories_api#products
#                                        root GET        /                                                         home#index
#                                dynamic_path GET        /*path(.:format)                                          dynamic_path#show_path
#
# Routes for Ckeditor::Engine:
#         pictures GET    /pictures(.:format)             ckeditor/pictures#index
#                  POST   /pictures(.:format)             ckeditor/pictures#create
#          picture DELETE /pictures/:id(.:format)         ckeditor/pictures#destroy
# attachment_files GET    /attachment_files(.:format)     ckeditor/attachment_files#index
#                  POST   /attachment_files(.:format)     ckeditor/attachment_files#create
#  attachment_file DELETE /attachment_files/:id(.:format) ckeditor/attachment_files#destroy
#


class RouteConstraint
  def matches?(request)
    url_path = request.path.downcase

    includes = url_path.starts_with?('/assets')
    includes |= url_path.starts_with?('"') || url_path.starts_with?('/%22')
    includes |= url_path.starts_with?('/system')
    includes |= url_path.ends_with?('.jpg') || url_path.ends_with?('.jpeg')
    includes |= url_path.ends_with?('.png')
    includes |= url_path.ends_with?('.css')
    includes |= url_path.ends_with?('.html')
    includes |= url_path.ends_with?('.js')
    includes |= url_path.ends_with?('.gif')

    includes |= url_path.ends_with?('.pdf')
    includes |= url_path.ends_with?('.csv')
    includes |= url_path.ends_with?('.doc') || url_path.ends_with?('.docx')
    includes |= url_path.ends_with?('.xls') || url_path.ends_with?('.xlsx')

    not includes
  end
end

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
  resources :categories, only: [:index] do
    get '/' => 'categories#show'
    get '/products/:product_id' => 'products#show', as: :show_product_slug
    match '/tags/*slug_tags' => 'categories#tags', as: :tags, via: [:get]
  end

  match '/tags/*slug_tags' => 'categories#tags', as: :tags, via: [:get]

  resources :products, only: [:index] do
    get '/' => 'products#show'
    get '/add_to_shopping_cart' => 'products#add_to_shopping_cart', as: :add_to_shopping_cart
    get '/delete_from_shopping_cart' => 'products#delete_from_shopping_cart', as: :delete_from_shopping_cart
  end

  resource :searches, only: [] do
    post '/' => 'searches#index'
  end

  resource :shopping_carts, only: [] do
    get '/show' => 'shopping_carts#show'
    get '/clear' => 'shopping_carts#clear'
    post '/:product_id/update' => 'shopping_carts#update', as: :update

    post '/save' => 'shopping_carts#save'
  end

  resource :customers, only: [] do
    get '/show' => 'customers#show'
    get '/orders' => 'customers#orders'
    get '/orders/:id/invoice' => 'customers#invoice', as: :orders_invoice

    resources :addresses

    resource :shopping_orders, only: [] do
      get '/shipping_method' => 'shopping_orders#shipping_method'
      get '/:type/addresses' => 'shopping_orders#addresses', as: :addresses
      post '/:id/save_address' => 'shopping_orders#save_address', as: :save_address

      post '/save_carrier' => 'shopping_orders#save_carrier'
      get '/checkout' => 'shopping_orders#checkout'
      post '/finalize' => 'shopping_orders#finalize'
    end
  end

  get '/locale/:locale' => 'application#change_locale', :as => 'change_locale'

  # From https://www.airpair.com/ruby-on-rails/posts/building-a-restful-api-in-a-rails-application
  scope '/api' do
    scope '/v1' do
      scope '/data_forms' do
        post '/' => 'api/data_forms#create'
      end

      scope '/categories' do
        get '/:category_id/products' => 'api/categories_api#products'
      end
    end
  end

  # You can have the root of your site routed with "root"
  root 'home#index'

  get '*path' => 'dynamic_path#show_path', constraints: RouteConstraint.new, as: :dynamic_path

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
