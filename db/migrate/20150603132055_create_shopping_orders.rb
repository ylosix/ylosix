class CreateShoppingOrders < ActiveRecord::Migration
  def change
    create_table :shopping_orders do |t|
      t.references :customer, index: true

      t.timestamps null: false
    end

    add_foreign_key :shopping_orders, :customers, on_update: :cascade, on_delete: :cascade
  end
end
