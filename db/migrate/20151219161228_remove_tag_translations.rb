class RemoveTagTranslations < ActiveRecord::Migration
  def change
    remove_column :tags, :name
    add_column :tags, :name, :hstore, null: false, default: {}
    add_column :tags, :slug, :hstore, null: false, default: {}

    TagTranslation.all.each do |t|
      object = t.tag

      object.name[t.locale.to_sym] = t.name
      object.slug[t.locale.to_sym] = t.slug
      object.save
    end
  end
end
