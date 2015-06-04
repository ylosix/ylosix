class RenameTaxPercentOrders < ActiveRecord::Migration
  def change
    rename_column :shopping_orders_products, :tax_percent, :tax_rate
    change_column :shopping_orders_products, :tax_rate, :decimal, precision: 5, scale: 2, default: 0
  end
end
