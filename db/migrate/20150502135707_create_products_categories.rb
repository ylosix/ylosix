class CreateProductsCategories < ActiveRecord::Migration
  def change
    create_table :products_categories do |t|
      t.references :product
      t.references :category

      t.timestamps null: false
    end

    add_index :products_categories, [:category_id, :product_id]
    add_index :products_categories, :category_id
    add_index :products_categories, :product_id
  end
end
