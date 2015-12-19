class RemoveActionFromTranslations < ActiveRecord::Migration
  def change
    add_column :action_forms, :subject, :hstore, null: false, default: {}
    add_column :action_forms, :body, :hstore, null: false, default: {}

    ActionFormTranslation.all.each do |t|
      object = t.action_form

      object.subject[t.locale.to_sym] = t.subject
      object.body[t.locale.to_sym] = t.body
      object.save
    end
  end
end
