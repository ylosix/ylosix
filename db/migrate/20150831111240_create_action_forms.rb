class CreateActionForms < ActiveRecord::Migration
  def change
    create_table :action_forms do |t|
      t.string :tag
      t.hstore :mapping, default: {}, null: false

      t.timestamps null: false
    end

    ActionForm.create_translation_table! :subject => :string, :body => :text
  end
end
