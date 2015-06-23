class AddCommerceOrders < ActiveRecord::Migration
  def change
    add_column :shopping_orders, :commerce_id, :integer
    add_column :shopping_orders, :shipping_address, :hstore, default: {}, null: false
    add_column :shopping_orders, :billing_address, :hstore, default: {}, null: false
    add_column :shopping_orders, :billing_commerce, :hstore, default: {}, null: false
    change_column :commerces, :billing_address, :hstore, default: {}, null: false

    add_foreign_key :shopping_orders, :commerces, on_update: :cascade, on_delete: :cascade

    drop_table :shopping_orders_addresses
  end
end
