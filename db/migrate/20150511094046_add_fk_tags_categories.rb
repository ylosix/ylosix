class AddFkTagsCategories < ActiveRecord::Migration
  def change
    add_foreign_key :products_categories, :products, on_delete: :cascade, on_update: :cascade
    add_foreign_key :products_categories, :categories, on_delete: :cascade, on_update: :cascade

    add_foreign_key :products_tags, :products, on_delete: :cascade, on_update: :cascade
    add_foreign_key :products_tags, :tags, on_delete: :cascade, on_update: :cascade
  end
end
