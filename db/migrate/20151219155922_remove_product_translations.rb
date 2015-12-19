class RemoveProductTranslations < ActiveRecord::Migration
  def change
    remove_column :products, :description
    add_column :products, :description, :hstore, null: false, default: {}

    add_column :products, :features, :hstore, null: false, default: {}
    add_column :products, :meta_tags, :hstore, null: false, default: {}
    remove_column :products, :name
    add_column :products, :name, :hstore, null: false, default: {}

    remove_column :products, :short_description
    add_column :products, :short_description, :hstore, null: false, default: {}
    add_column :products, :slug, :hstore, null: false, default: {}

    ProductTranslation.all.each do |t|
      object = t.product

      object.name[t.locale.to_sym] = t.name
      object.short_description[t.locale.to_sym] = t.short_description
      object.description[t.locale.to_sym] = t.description
      object.features[t.locale.to_sym] = t.features
      object.slug[t.locale.to_sym] = t.slug
      object.meta_tags[t.locale.to_sym] = t.meta_tags
      object.save
    end
  end
end
