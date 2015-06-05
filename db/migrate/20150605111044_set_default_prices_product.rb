class SetDefaultPricesProduct < ActiveRecord::Migration
  def change
    change_column :products, :retail_price, :decimal, precision: 10, scale: 2, default:0, null: false
    change_column :products, :retail_price_pre_tax, :decimal, precision: 10, scale: 5, default:0, null: false
    change_column :products, :slug, :string, null: false
  end
end
