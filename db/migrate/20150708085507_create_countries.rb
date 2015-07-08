class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :code
      t.string :name
      t.string :iso
      t.boolean :enabled, null:false, default: false
      t.references :zone, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
