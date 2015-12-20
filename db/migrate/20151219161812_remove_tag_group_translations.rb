class RemoveTagGroupTranslations < ActiveRecord::Migration
  def change
    remove_column :tags_groups, :name
    add_column :tags_groups, :name_translations, :hstore, null: false, default: {}

    TagsGroupTranslation.all.each do |t|
      object = t.tags_group

      object.name_translations[t.locale.to_sym] = t.name
      object.save
    end
  end
end
