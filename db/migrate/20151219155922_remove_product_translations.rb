class RemoveProductTranslations < ActiveRecord::Migration
  def change
    remove_column :products, :description
    add_column :products, :description_translations, :hstore, null: false, default: {}

    add_column :products, :features_translations, :hstore, null: false, default: {}
    add_column :products, :meta_tags_translations, :hstore, null: false, default: {}
    remove_column :products, :name
    add_column :products, :name_translations, :hstore, null: false, default: {}

    remove_column :products, :short_description
    add_column :products, :short_description_translations, :hstore, null: false, default: {}
    add_column :products, :slug_translations, :hstore, null: false, default: {}

    ProductTranslation.all.each do |t|
      object = t.product

      object.name_translations[t.locale.to_sym] = t.name
      object.short_description_translations[t.locale.to_sym] = t.short_description
      object.description_translations[t.locale.to_sym] = t.description
      object.features_translations[t.locale.to_sym] = t.features
      object.slug_translations[t.locale.to_sym] = t.slug
      object.meta_tags_translations[t.locale.to_sym] = t.meta_tags
      object.save
    end
  end
end
