class SetDefaultCategoryName < ActiveRecord::Migration
  def change
    change_column :category_translations, :name, :string, null: false, default: ''
    change_column :category_translations, :short_description, :text, null: false, default: ''
    change_column :category_translations, :description, :text, null: false, default: ''
    change_column :category_translations, :slug, :string, null: false, default: ''

    add_index :category_translations, :slug
  end
end
