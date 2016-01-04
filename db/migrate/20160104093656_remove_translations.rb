class RemoveTranslations < ActiveRecord::Migration
  def change
    drop_table :action_form_translations
    drop_table :carrier_translations
    drop_table :category_translations
    drop_table :design_form_translations
    drop_table :product_translations
    drop_table :shopping_orders_status_translations
    drop_table :snippet_translations
    drop_table :tag_translations
    drop_table :tags_group_translations
    drop_table :feature_translations
  end
end
