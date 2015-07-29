class AddShoppingCarrierPrice < ActiveRecord::Migration
  def change
    add_column :shopping_carts, :carrier_retail_price, :decimal, precision: 10, scale: 2, default: 0, null: false
    add_column :shopping_orders, :carrier_retail_price, :decimal, precision: 10, scale: 2, default: 0, null: false
  end
end
