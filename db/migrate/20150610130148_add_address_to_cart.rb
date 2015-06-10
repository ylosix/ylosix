class AddAddressToCart < ActiveRecord::Migration
  def change
    add_column :shopping_carts, :shipping_address_id, :integer, index: true
    add_column :shopping_carts, :billing_address_id, :integer, index: true

    add_foreign_key :shopping_carts, :customer_addresses, column: :shipping_address_id, on_update: :cascade, on_delete: :cascade
    add_foreign_key :shopping_carts, :customer_addresses, column: :billing_address_id, on_update: :cascade, on_delete: :cascade
  end
end
