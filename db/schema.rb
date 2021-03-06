# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160901121221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "action_forms", force: :cascade do |t|
    t.string   "tag"
    t.hstore   "mapping",              default: {}, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.hstore   "subject_translations", default: {}, null: false
    t.hstore   "body_translations",    default: {}, null: false
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "locale",                 default: "en",  null: false
    t.boolean  "debug_variables",        default: false, null: false
    t.integer  "debug_template_id"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "carriers", force: :cascade do |t|
    t.boolean  "enabled",            default: false, null: false
    t.boolean  "free_carrier",       default: false, null: false
    t.integer  "priority",           default: 1,     null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.hstore   "delay_translations", default: {},    null: false
    t.hstore   "name_translations",  default: {},    null: false
  end

  add_index "carriers", ["enabled"], name: "index_carriers_on_enabled", using: :btree

  create_table "carriers_ranges", force: :cascade do |t|
    t.integer  "zone_id"
    t.integer  "carrier_id"
    t.decimal  "greater_equal_than"
    t.decimal  "lower_than"
    t.decimal  "amount"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "carriers_ranges", ["carrier_id"], name: "index_carriers_ranges_on_carrier_id", using: :btree
  add_index "carriers_ranges", ["zone_id"], name: "index_carriers_ranges_on_zone_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.integer  "parent_id"
    t.boolean  "enabled",                        default: false
    t.boolean  "visible",                        default: true
    t.string   "reference_code"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "priority",                       default: 1,     null: false
    t.string   "show_action_name"
    t.hstore   "description_translations",       default: {},    null: false
    t.hstore   "short_description_translations", default: {},    null: false
    t.hstore   "meta_tags_translations",         default: {},    null: false
    t.hstore   "slug_translations",              default: {},    null: false
    t.hstore   "name_translations",              default: {},    null: false
    t.hstore   "href_translations",              default: {},    null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "categories", ["enabled"], name: "index_categories_on_enabled", using: :btree
  add_index "categories", ["parent_id"], name: "index_categories_on_parent_id", using: :btree
  add_index "categories", ["reference_code"], name: "index_categories_on_reference_code", using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "commerces", force: :cascade do |t|
    t.string   "http"
    t.string   "name"
    t.integer  "template_id"
    t.boolean  "default"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.hstore   "billing_address",           default: {},    null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "ga_account_id"
    t.string   "order_prefix",              default: "",    null: false
    t.boolean  "no_redirect_shopping_cart", default: false, null: false
    t.hstore   "social_networks",           default: {},    null: false
    t.integer  "language_id"
    t.hstore   "meta_tags",                 default: {},    null: false
    t.integer  "per_page",                  default: 20
    t.boolean  "enable_commerce_options",   default: false, null: false
    t.integer  "tree_category_id"
  end

  add_index "commerces", ["default", "http"], name: "index_commerces_on_default_and_http", using: :btree
  add_index "commerces", ["default"], name: "index_commerces_on_default", using: :btree
  add_index "commerces", ["http"], name: "index_commerces_on_http", using: :btree
  add_index "commerces", ["template_id"], name: "index_commerces_on_template_id", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.string   "iso"
    t.boolean  "enabled",    default: false, null: false
    t.integer  "zone_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "countries", ["code"], name: "index_countries_on_code", using: :btree
  add_index "countries", ["enabled"], name: "index_countries_on_enabled", using: :btree
  add_index "countries", ["zone_id"], name: "index_countries_on_zone_id", using: :btree

  create_table "customer_addresses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.hstore   "fields",           default: {},    null: false
    t.integer  "customer_id"
    t.boolean  "default_shipping", default: false, null: false
    t.boolean  "default_billing",  default: false, null: false
  end

  add_index "customer_addresses", ["customer_id"], name: "index_customer_addresses_on_customer_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "last_name"
    t.date     "birth_date"
    t.boolean  "enabled"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "locale",                 default: "en", null: false
  end

  add_index "customers", ["email"], name: "index_customers_on_email", unique: true, using: :btree
  add_index "customers", ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true, using: :btree

  create_table "data_forms", force: :cascade do |t|
    t.string   "tag"
    t.hstore   "fields",     default: {}, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "design_forms", force: :cascade do |t|
    t.string   "tag"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.hstore   "content_translations", default: {}, null: false
  end

  create_table "features", force: :cascade do |t|
    t.integer  "priority",          default: 1,  null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.hstore   "name_translations", default: {}, null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string   "locale"
    t.boolean  "appears_in_backoffice", default: false
    t.boolean  "appears_in_web",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "flag_file_name"
    t.string   "flag_content_type"
    t.integer  "flag_file_size"
    t.datetime "flag_updated_at"
    t.string   "name"
    t.boolean  "default",               default: false
  end

  add_index "languages", ["default"], name: "index_languages_on_default", using: :btree
  add_index "languages", ["locale", "appears_in_web"], name: "index_languages_on_locale_and_appears_in_web", using: :btree
  add_index "languages", ["locale"], name: "index_languages_on_locale", using: :btree

  create_table "links", force: :cascade do |t|
    t.string   "class_name", null: false
    t.integer  "object_id",  null: false
    t.string   "slug",       null: false
    t.string   "locale",     null: false
    t.boolean  "enabled",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "href"
  end

  add_index "links", ["class_name"], name: "index_links_on_class_name", using: :btree
  add_index "links", ["object_id"], name: "index_links_on_object_id", using: :btree
  add_index "links", ["slug"], name: "index_links_on_slug", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "reference_code"
    t.string   "barcode"
    t.boolean  "enabled",                                                 default: false
    t.boolean  "visible",                                                 default: true
    t.datetime "publication_date",                                                        null: false
    t.datetime "unpublication_date"
    t.decimal  "retail_price_pre_tax",           precision: 10, scale: 5, default: 0.0,   null: false
    t.decimal  "retail_price",                   precision: 10, scale: 2, default: 0.0,   null: false
    t.integer  "tax_id"
    t.integer  "stock",                                                   default: 0
    t.boolean  "control_stock",                                           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.decimal  "width",                          precision: 10, scale: 6, default: 0.0,   null: false
    t.decimal  "height",                         precision: 10, scale: 6, default: 0.0,   null: false
    t.decimal  "depth",                          precision: 10, scale: 6, default: 0.0,   null: false
    t.decimal  "weight",                         precision: 10, scale: 6, default: 0.0,   null: false
    t.string   "show_action_name"
    t.hstore   "description_translations",                                default: {},    null: false
    t.hstore   "features_translations",                                   default: {},    null: false
    t.hstore   "meta_tags_translations",                                  default: {},    null: false
    t.hstore   "name_translations",                                       default: {},    null: false
    t.hstore   "short_description_translations",                          default: {},    null: false
    t.hstore   "slug_translations",                                       default: {},    null: false
    t.hstore   "href_translations",                                       default: {},    null: false
  end

  add_index "products", ["enabled"], name: "index_products_on_enabled", using: :btree
  add_index "products", ["tax_id"], name: "index_products_on_tax_id", using: :btree
  add_index "products", ["visible"], name: "index_products_on_visible", using: :btree

  create_table "products_categories", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "products_categories", ["category_id", "product_id"], name: "index_products_categories_on_category_id_and_product_id", using: :btree
  add_index "products_categories", ["category_id"], name: "index_products_categories_on_category_id", using: :btree
  add_index "products_categories", ["product_id"], name: "index_products_categories_on_product_id", using: :btree

  create_table "products_pictures", force: :cascade do |t|
    t.integer  "priority",           default: 1, null: false
    t.integer  "product_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "products_pictures", ["product_id"], name: "index_products_pictures_on_product_id", using: :btree

  create_table "products_tags", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "products_tags", ["product_id"], name: "index_products_tags_on_product_id", using: :btree
  add_index "products_tags", ["tag_id", "product_id"], name: "index_products_tags_on_tag_id_and_product_id", using: :btree
  add_index "products_tags", ["tag_id"], name: "index_products_tags_on_tag_id", using: :btree

  create_table "shopping_carts", force: :cascade do |t|
    t.integer  "customer_id"
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.integer  "shipping_address_id"
    t.integer  "billing_address_id"
    t.integer  "carrier_id"
    t.decimal  "carrier_retail_price", precision: 10, scale: 2, default: 0.0, null: false
    t.hstore   "extra_fields",                                  default: {},  null: false
  end

  add_index "shopping_carts", ["customer_id"], name: "index_shopping_carts_on_customer_id", using: :btree

  create_table "shopping_carts_products", force: :cascade do |t|
    t.integer  "shopping_cart_id"
    t.integer  "product_id"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.integer  "quantity",                                  default: 1,   null: false
    t.decimal  "retail_price",     precision: 10, scale: 2, default: 0.0, null: false
    t.hstore   "extra_fields",                              default: {},  null: false
  end

  add_index "shopping_carts_products", ["product_id"], name: "index_shopping_carts_products_on_product_id", using: :btree
  add_index "shopping_carts_products", ["shopping_cart_id"], name: "index_shopping_carts_products_on_shopping_cart_id", using: :btree

  create_table "shopping_orders", force: :cascade do |t|
    t.integer  "customer_id"
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.integer  "commerce_id"
    t.hstore   "shipping_address",                                   default: {},  null: false
    t.hstore   "billing_address",                                    default: {},  null: false
    t.hstore   "billing_commerce",                                   default: {},  null: false
    t.integer  "order_num",                                          default: 0,   null: false
    t.integer  "carrier_id"
    t.decimal  "carrier_retail_price",      precision: 10, scale: 2, default: 0.0, null: false
    t.integer  "shopping_orders_status_id"
    t.hstore   "extra_fields",                                       default: {},  null: false
  end

  add_index "shopping_orders", ["customer_id"], name: "index_shopping_orders_on_customer_id", using: :btree

  create_table "shopping_orders_products", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "shopping_order_id"
    t.integer  "quantity",                                      default: 1,   null: false
    t.decimal  "retail_price_pre_tax", precision: 10, scale: 5, default: 0.0, null: false
    t.decimal  "retail_price",         precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "tax_rate",             precision: 5,  scale: 2, default: 0.0, null: false
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.hstore   "extra_fields",                                  default: {},  null: false
  end

  add_index "shopping_orders_products", ["product_id"], name: "index_shopping_orders_products_on_product_id", using: :btree
  add_index "shopping_orders_products", ["shopping_order_id"], name: "index_shopping_orders_products_on_shopping_order_id", using: :btree

  create_table "shopping_orders_statuses", force: :cascade do |t|
    t.boolean  "enable_invoice"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "color"
    t.hstore   "name_translations", default: {}, null: false
  end

  create_table "snippets", force: :cascade do |t|
    t.string   "tag"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.hstore   "content_translations", default: {}, null: false
  end

  add_index "snippets", ["tag"], name: "index_snippets_on_tag", using: :btree

  create_table "tags", force: :cascade do |t|
    t.integer  "tags_group_id"
    t.integer  "priority",          default: 1,  null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.hstore   "name_translations", default: {}, null: false
    t.hstore   "slug_translations", default: {}, null: false
    t.hstore   "href_translations", default: {}, null: false
  end

  add_index "tags", ["tags_group_id"], name: "index_tags_on_tags_group_id", using: :btree

  create_table "tags_groups", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.hstore   "name_translations", default: {}, null: false
  end

  create_table "tags_groups_categories", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "tags_group_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "tags_groups_categories", ["category_id"], name: "index_tags_groups_categories_on_category_id", using: :btree
  add_index "tags_groups_categories", ["tags_group_id"], name: "index_tags_groups_categories_on_tags_group_id", using: :btree

  create_table "taxes", force: :cascade do |t|
    t.string   "name"
    t.decimal  "rate",       precision: 5, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "templates", force: :cascade do |t|
    t.string   "name"
    t.string   "path"
    t.boolean  "enabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "templates", ["enabled"], name: "index_templates_on_enabled", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "zones", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "carriers_ranges", "carriers"
  add_foreign_key "carriers_ranges", "zones"
  add_foreign_key "commerces", "templates", on_update: :cascade, on_delete: :cascade
  add_foreign_key "countries", "zones"
  add_foreign_key "customer_addresses", "customers", on_update: :cascade, on_delete: :cascade
  add_foreign_key "products", "taxes", on_update: :cascade, on_delete: :cascade
  add_foreign_key "products_categories", "categories", on_update: :cascade, on_delete: :cascade
  add_foreign_key "products_categories", "products", on_update: :cascade, on_delete: :cascade
  add_foreign_key "products_pictures", "products", on_update: :cascade, on_delete: :cascade
  add_foreign_key "products_tags", "products", on_update: :cascade, on_delete: :cascade
  add_foreign_key "products_tags", "tags", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shopping_carts", "customer_addresses", column: "billing_address_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shopping_carts", "customer_addresses", column: "shipping_address_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shopping_carts", "customers", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shopping_carts_products", "products", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shopping_carts_products", "shopping_carts", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shopping_orders", "carriers", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shopping_orders", "commerces", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shopping_orders", "customers", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shopping_orders_products", "products", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shopping_orders_products", "shopping_orders", on_update: :cascade, on_delete: :cascade
  add_foreign_key "tags_groups_categories", "categories", on_update: :cascade, on_delete: :cascade
  add_foreign_key "tags_groups_categories", "tags_groups", on_update: :cascade, on_delete: :cascade
end
