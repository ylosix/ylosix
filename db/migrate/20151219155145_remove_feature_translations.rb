class RemoveFeatureTranslations < ActiveRecord::Migration
  def change
    remove_column :features, :name
    add_column :features, :name_translations, :hstore, null: false, default: {}

    FeatureTranslation.all.each do |t|
      object = t.feature

      object.name_translations[t.locale.to_sym] = t.name
      object.save
    end
  end
end
