class CreateShoppingOrdersProducts < ActiveRecord::Migration
  def change
    create_table :shopping_orders_products do |t|
      t.references :product, index: true
      t.references :shopping_order, index: true

      t.integer :quantity, default: 1, null: false
      t.decimal :retail_price_pre_tax, precision: 10, scale: 5, default: 0, null: false
      t.decimal :retail_price, precision: 10, scale: 2, default: 0, null: false
      t.decimal :tax_percent, precision: 5, scale: 2, default: 0, null: false

      t.timestamps null: false
    end

    add_foreign_key :shopping_orders_products, :products, on_update: :cascade, on_delete: :cascade
    add_foreign_key :shopping_orders_products, :shopping_orders, on_update: :cascade, on_delete: :cascade
  end
end
