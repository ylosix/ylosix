class RemoveCategoryTranslations < ActiveRecord::Migration
  def change
    add_column :categories, :description_translations, :hstore, null: false, default: {}
    add_column :categories, :short_description_translations, :hstore, null: false, default: {}

    add_column :categories, :meta_tags_translations, :hstore, null: false, default: {}
    add_column :categories, :slug_translations, :hstore, null: false, default: {}

    remove_column :categories, :name
    add_column :categories, :name_translations, :hstore, null: false, default: {}

    CategoryTranslation.all.each do |t|
      object = t.category

      object.description_translations[t.locale.to_sym] = t.description
      object.short_description_translations[t.locale.to_sym] = t.short_description

      object.meta_tags_translations[t.locale.to_sym] = t.meta_tags
      object.slug_translations[t.locale.to_sym] = t.slug
      object.name_translations[t.locale.to_sym] = t.name
      object.save
    end
  end
end
