class CreateOpenForms < ActiveRecord::Migration
  def change
    create_table :open_forms do |t|
      t.string :tag
      t.hstore :fields, default: {}, null: false

      t.timestamps null: false
    end
  end
end
