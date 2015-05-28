class CreateShoppingCartProducts < ActiveRecord::Migration
  def change
    create_table :shopping_carts_products do |t|
      t.references :shopping_cart, index: true
      t.references :product, index: true

      t.timestamps null: false
    end

    add_foreign_key :shopping_carts_products, :shopping_carts, on_update: :cascade, on_delete: :cascade
    add_foreign_key :shopping_carts_products, :products, on_update: :cascade, on_delete: :cascade
  end
end
