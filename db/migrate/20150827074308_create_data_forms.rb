class CreateDataForms < ActiveRecord::Migration
  def change
    drop_table :open_forms

    create_table :data_forms do |t|
      t.string :tag
      t.hstore :fields, default: {}, null: false

      t.timestamps null: false
    end
  end
end
