class RemoveActionFromTranslations < ActiveRecord::Migration
  def change
    add_column :action_forms, :subject_translations, :hstore, null: false, default: {}
    add_column :action_forms, :body_translations, :hstore, null: false, default: {}

    ActionFormTranslation.all.each do |t|
      object = t.action_form

      object.subject_translations[t.locale.to_sym] = t.subject
      object.body_translations[t.locale.to_sym] = t.body
      object.save
    end
  end
end
