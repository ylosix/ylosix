class RemoveCategoryTranslations < ActiveRecord::Migration
  def change
    add_column :categories, :description, :hstore, null: false, default: {}
    add_column :categories, :short_description, :hstore, null: false, default: {}

    add_column :categories, :meta_tags, :hstore, null: false, default: {}
    add_column :categories, :slug, :hstore, null: false, default: {}

    remove_column :categories, :name
    add_column :categories, :name, :hstore, null: false, default: {}

    CategoryTranslation.all.each do |t|
      object = t.category

      object.description[t.locale.to_sym] = t.description
      object.short_description[t.locale.to_sym] = t.short_description

      object.meta_tags[t.locale.to_sym] = t.meta_tags
      object.slug[t.locale.to_sym] = t.slug
      object.name[t.locale.to_sym] = t.name
      object.save
    end
  end
end
