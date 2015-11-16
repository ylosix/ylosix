class AddIndexProductTranslations < ActiveRecord::Migration
  def change
    add_index :product_translations, :slug
  end
end
