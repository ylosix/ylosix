class AddProductAttributes < ActiveRecord::Migration
  def change
    add_column :products, :width, :decimal, precision: 10, scale: 6, default: 0.0, null: false
    add_column :products, :height, :decimal, precision: 10, scale: 6, default: 0.0, null: false
    add_column :products, :depth, :decimal, precision: 10, scale: 6, default: 0.0, null: false
    add_column :products, :weight, :decimal, precision: 10, scale: 6, default: 0.0, null: false
  end
end
