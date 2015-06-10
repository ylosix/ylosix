class CreateShoppingOrdersAddresses < ActiveRecord::Migration
  def change
    create_table :shopping_orders_addresses do |t|
      t.references :shopping_order, index: true
      t.boolean :shipping, null: false, default: false
      t.boolean :billing, null: false, default: false
      t.hstore :fields, null:false, default: {}

      t.timestamps null: false
    end

    add_foreign_key :shopping_orders_addresses, :shopping_orders, on_update: :cascade, on_delete: :cascade
  end
end
