class AddExtraFieldsShopping < ActiveRecord::Migration
  def change
    add_column :shopping_carts, :extra_fields, :hstore, null: false, default: {}
    add_column :shopping_orders, :extra_fields, :hstore, null: false, default: {}

    add_column :shopping_carts_products, :extra_fields, :hstore, null: false, default: {}
    add_column :shopping_orders_products, :extra_fields, :hstore, null: false, default: {}
  end
end
