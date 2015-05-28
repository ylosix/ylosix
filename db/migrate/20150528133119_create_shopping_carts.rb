class CreateShoppingCarts < ActiveRecord::Migration
  def change
    create_table :shopping_carts do |t|
      t.references :customer, index: true

      t.timestamps null: false
    end

    add_foreign_key :shopping_carts, :customers, on_update: :cascade, on_delete: :cascade
  end
end
