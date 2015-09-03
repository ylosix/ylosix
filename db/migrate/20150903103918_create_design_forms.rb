class CreateDesignForms < ActiveRecord::Migration
  def change
    create_table :design_forms do |t|
      t.string :tag

      t.timestamps null: false
    end

    DesignForm.create_translation_table! :content => :text
  end
end
