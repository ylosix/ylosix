class RemoveCarrierTranslations < ActiveRecord::Migration
  def change
    remove_column :carriers, :delay
    add_column :carriers, :delay_translations, :hstore, null: false, default: {}

    remove_column :carriers, :name
    add_column :carriers, :name_translations, :hstore, null: false, default: {}

    CarrierTranslation.all.each do |t|
      object = t.carrier

      object.delay_translations[t.locale.to_sym] = t.delay
      object.name_translations[t.locale.to_sym] = t.name
      object.save
    end
  end
end
