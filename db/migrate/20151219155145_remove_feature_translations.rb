class RemoveFeatureTranslations < ActiveRecord::Migration
  def change
    remove_column :features, :name
    add_column :features, :name, :hstore, null: false, default: {}

    FeatureTranslation.all.each do |t|
      object = t.feature

      object.name[t.locale.to_sym] = t.name
      object.save
    end
  end
end
