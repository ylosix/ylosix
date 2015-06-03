class AddCartAttributes < ActiveRecord::Migration
  def change
    add_column :shopping_carts_products, :quantity, :integer, default: 1, null: false
    add_column :shopping_carts_products, :retail_price, :decimal, precision: 10, scale: 2, default:0, null: false
  end
end
