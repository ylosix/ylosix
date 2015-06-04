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

ActiveRecord::Schema.define(version: 20150604100132) do

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

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: :cascade do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "locale",                 default: "en", null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "categories", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.boolean  "enabled",          default: false
    t.boolean  "appears_in_web",   default: true
    t.string   "meta_keywords"
    t.string   "meta_description"
    t.string   "slug"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "categories", ["parent_id"], name: "index_categories_on_parent_id"
  add_index "categories", ["slug"], name: "index_categories_on_slug"

  create_table "category_translations", force: :cascade do |t|
    t.integer  "category_id", null: false
    t.string   "locale",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
  end

  add_index "category_translations", ["category_id"], name: "index_category_translations_on_category_id"
  add_index "category_translations", ["locale"], name: "index_category_translations_on_locale"

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

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

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

  add_index "customers", ["email"], name: "index_customers_on_email", unique: true
  add_index "customers", ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true

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
  end

  add_index "languages", ["locale"], name: "index_languages_on_locale"

  create_table "product_translations", force: :cascade do |t|
    t.integer  "product_id",        null: false
    t.string   "locale",            null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "name"
    t.text     "short_description"
    t.text     "description"
  end

  add_index "product_translations", ["locale"], name: "index_product_translations_on_locale"
  add_index "product_translations", ["product_id"], name: "index_product_translations_on_product_id"

  create_table "products", force: :cascade do |t|
    t.string   "reference_code"
    t.string   "name"
    t.string   "barcode"
    t.boolean  "enabled",                                        default: false
    t.boolean  "appears_in_categories",                          default: true
    t.boolean  "appears_in_tag",                                 default: true
    t.boolean  "appears_in_search",                              default: true
    t.string   "short_description"
    t.text     "description"
    t.datetime "publication_date",                               default: '2015-01-01 00:00:00', null: false
    t.datetime "unpublication_date"
    t.decimal  "retail_price_pre_tax",  precision: 10, scale: 5
    t.decimal  "retail_price",          precision: 10, scale: 2
    t.integer  "tax_id"
    t.string   "meta_keywords"
    t.string   "meta_description"
    t.string   "slug"
    t.integer  "stock",                                          default: 0
    t.boolean  "control_stock",                                  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "products", ["tax_id"], name: "index_products_on_tax_id"

  create_table "products_categories", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "products_categories", ["category_id", "product_id"], name: "index_products_categories_on_category_id_and_product_id"
  add_index "products_categories", ["category_id"], name: "index_products_categories_on_category_id"
  add_index "products_categories", ["product_id"], name: "index_products_categories_on_product_id"

  create_table "products_tags", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "products_tags", ["product_id"], name: "index_products_tags_on_product_id"
  add_index "products_tags", ["tag_id", "product_id"], name: "index_products_tags_on_tag_id_and_product_id"
  add_index "products_tags", ["tag_id"], name: "index_products_tags_on_tag_id"

  create_table "shopping_carts", force: :cascade do |t|
    t.integer  "customer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "shopping_carts", ["customer_id"], name: "index_shopping_carts_on_customer_id"

  create_table "shopping_carts_products", force: :cascade do |t|
    t.integer  "shopping_cart_id"
    t.integer  "product_id"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.integer  "quantity",                                  default: 1,   null: false
    t.decimal  "retail_price",     precision: 10, scale: 2, default: 0.0, null: false
  end

  add_index "shopping_carts_products", ["product_id"], name: "index_shopping_carts_products_on_product_id"
  add_index "shopping_carts_products", ["shopping_cart_id"], name: "index_shopping_carts_products_on_shopping_cart_id"

  create_table "shopping_orders", force: :cascade do |t|
    t.integer  "customer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "shopping_orders", ["customer_id"], name: "index_shopping_orders_on_customer_id"

  create_table "shopping_orders_products", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "shopping_order_id"
    t.integer  "quantity",                                      default: 1,   null: false
    t.decimal  "retail_price_pre_tax", precision: 10, scale: 5, default: 0.0, null: false
    t.decimal  "retail_price",         precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "tax_rate",             precision: 5,  scale: 2, default: 0.0, null: false
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
  end

  add_index "shopping_orders_products", ["product_id"], name: "index_shopping_orders_products_on_product_id"
  add_index "shopping_orders_products", ["shopping_order_id"], name: "index_shopping_orders_products_on_shopping_order_id"

  create_table "tag_translations", force: :cascade do |t|
    t.integer  "tag_id",     null: false
    t.string   "locale",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  add_index "tag_translations", ["locale"], name: "index_tag_translations_on_locale"
  add_index "tag_translations", ["tag_id"], name: "index_tag_translations_on_tag_id"

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "priority",       default: 1
    t.boolean  "appears_in_web"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "tags", ["parent_id"], name: "index_tags_on_parent_id"

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

end
