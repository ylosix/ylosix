class CreateProductsTags < ActiveRecord::Migration
  def change
    create_table :products_tags do |t|
      t.references :product
      t.references :tag

      t.timestamps null: false
    end

    add_index :products_tags, [:tag_id, :product_id]
    add_index :products_tags, :tag_id
    add_index :products_tags, :product_id
  end
end
