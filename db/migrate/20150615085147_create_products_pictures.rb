class CreateProductsPictures < ActiveRecord::Migration
  def change
    create_table :products_pictures do |t|
      t.integer :priority, null: false, default: 1
      t.references :product, index: true

      t.timestamps null: false
    end

    add_foreign_key :products_pictures, :products, on_update: :cascade, on_delete: :cascade
    add_attachment :products_pictures, :image
  end
end
