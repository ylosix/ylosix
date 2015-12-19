class RemoveDesignFormTranslations < ActiveRecord::Migration
  def change
    add_column :design_forms, :content, :hstore, null: false, default: {}

    DesignFormTranslation.all.each do |t|
      object = t.design_form

      object.content[t.locale.to_sym] = t.content
      object.save
    end
  end
end
